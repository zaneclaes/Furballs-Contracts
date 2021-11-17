// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "./Fur.sol";
import "./utils/FurProxy.sol";
import "./utils/MetaData.sol";
import "./l2/L2Lib.sol";
import "./l2/Fuel.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
// import "hardhat/console.sol";

/// @title Furgreement
/// @author LFG Gaming LLC
/// @notice L2 proxy authority; has permissions to write to main contract(s)
contract Furgreement is EIP712, FurProxy {
  // Tracker of wallet balances
  Fuel public fuel;

  // Simple, fast check for a single allowed proxy...
  address private _job;

  // Internal tracker for a furball
  struct LastGain {
    uint32 total;
    uint32 experience;
    uint64 timestamp;
  }

  // Tightly packed EXP gain + timestamp
  mapping(uint32 => LastGain) public lastGain;

  // Silly internal count of furball token to its number overall
  mapping(uint256 => uint32) public tokenToNumber;

  constructor(
    address furballsAddress, address fuelAddress
  ) EIP712("Furgreement", "1") FurProxy(furballsAddress) {
    fuel = Fuel(fuelAddress);
    _job = msg.sender;
  }

  /// @notice Player signs an EIP-712 authorizing the ticket (fuel) usage
  function runTimekeeper(
    L2Lib.TimekeeperRequest[] calldata tkRequests,
    bytes[] calldata signatures
  ) external allowedProxy {
    for (uint i=0; i<tkRequests.length; i++) {
      uint errorCode = _runTimekeeper(tkRequests[i], signatures[i]);
      require(errorCode == 0, string(abi.encodePacked(
        FurLib.bytesHex(abi.encode(tkRequests[i].sender)),
        ":",
        FurLib.uint2str(errorCode)
      )));
    }
  }

  /// @notice Public validation function can check that the signature was valid ahead of time
  function validateTimekeeper(
    L2Lib.TimekeeperRequest memory tkRequest,
    bytes memory signature
  ) public view returns (uint) {
    return _validateTimekeeper(tkRequest, signature);
  }

  /// @notice Single Timekeeper run for one player; validates EIP-712 request
  function _runTimekeeper(
    L2Lib.TimekeeperRequest memory tkRequest,
    bytes memory signature
  ) internal returns (uint) {
    // Check the EIP-712 signature.
    uint errorCode = _validateTimekeeper(tkRequest, signature);
    if (errorCode != 0) return errorCode;

    // Burn tickets, etc.
    if (tkRequest.tickets > 0) fuel.burn(tkRequest.sender, tkRequest.tickets);

    //  Earn FUR (must be at least the amount approved by player)
    require(tkRequest.furReal >= tkRequest.furGained, "FUR");
    if (tkRequest.furReal > 0) {
      furballs.fur().earn(tkRequest.sender, tkRequest.furReal);
    }

    // Spend FUR (everything approved by player)
    if (tkRequest.furSpent > 0) {
      // Spend the FUR required for these actions
      furballs.fur().spend(tkRequest.sender, tkRequest.furSpent);
    }

    // Each round represents a furball
    for (uint i=0; i<tkRequest.rounds.length; i++) {
      _resolveRound(tkRequest.rounds[i], tkRequest.sender);
    }

    // Mint new furballs from an edition
    if (tkRequest.mintEdition > 0) {
      // Edition is one-indexed, to allow for null
      address[] memory to = new address[](1);
      to[0] = tkRequest.sender;

      // "Gift" the mint (FUR purchase should have been done above)
      furballs.mint(to, tkRequest.mintEdition - 1, address(this));
    }

    // // Change zonens happens at the very end of the turn, so buffs can take effect
    // if (tkRequest.movements.length > 1) {
    //   _changeZones(tkRequest.movements, tkRequest.sender);
    // }

    return errorCode; // no error
  }

  /// @notice Validate a timekeeper request
  function _validateTimekeeper(
    L2Lib.TimekeeperRequest memory tkRequest,
    bytes memory signature
  ) internal view returns (uint) {
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
      keccak256("TimekeeperRequest(address sender,uint32 fuel,uint32 fur_gained,uint32 fur_spent,uint8 mint_edition,uint64 deadline)"),
      tkRequest.sender,
      tkRequest.tickets,
      tkRequest.furGained,
      tkRequest.furSpent,
      tkRequest.mintEdition,
      tkRequest.deadline
    )));

    address signer = ECDSA.recover(digest, signature);
    if (signer != tkRequest.sender) return 1;
    if (signer == address(0)) return 2;
    if (tkRequest.deadline != 0 && block.timestamp >= tkRequest.deadline) return 3;

    return 0;
  }

  /// @notice Give rewards/outcomes directly
  function _resolveRound(L2Lib.RoundResolution memory round, address sender) internal {
    if (round.expGained > 0) {
      // EXP gain (in explore mode)
      lastGain[round.number].timestamp = uint64(block.timestamp);
      lastGain[round.number].experience = round.expGained;
    // if (tokenToNumber[round.tokenId] == 0) {
    //   tokenToNumber[round.tokenId] = round.number;
    // }
    }

    if (round.items.length != 0) {
      // First item is an optional drop
      if (round.items[0] != 0)
        furballs.drop(round.tokenId, round.items[0], 1);

      // Other items are pickups
      for (uint j=1; j<round.items.length; j++) {
        furballs.pickup(round.tokenId, round.items[j]);
      }
    }

    // And purchase snacks
    for (uint i=0; i<round.snackStacks.length; i++) {
      _giveSnack(round.tokenId, round.snackStacks[i]);
    }
  }

  // /// @notice An array of "movements" can move many furballs at once.
  // function _changeZones(uint256[] memory movements, address sender) internal {
  //   uint temp = movements[0];
  //   uint8 numFurballs = uint8(temp);
  //   uint32 zone = uint32(temp >> 8);
  //   uint256[] memory tokenIds = new uint256[](numFurballs);
  //   uint fbIdx = 0;

  //   for (uint i=1; i<movements.length; i++) {
  //     if (movements[i] < 0x1000000) {
  //       furballs.playMany(tokenIds, zone, sender);
  //       temp = movements[i];
  //       numFurballs = uint8(temp);
  //       zone = uint32(temp >> 8);
  //       tokenIds = new uint256[](numFurballs);
  //       fbIdx = 0;
  //     } else {
  //       tokenIds[fbIdx] = movements[i];
  //       fbIdx = fbIdx + 1;
  //     }
  //   }

  //   furballs.playMany(tokenIds, zone, sender);
  // }

  /// @notice Purchase snacks from the EIP712
  function _giveSnack(uint256 tokenId, uint64 stack) internal {
    furballs.fur().giveSnack(tokenId, uint32(stack >> 16), uint16(stack));

    // Snacks are purchased as a "gift" because the FUR will be expended later.
  }

  /// @notice The furgreement can modify rewards
  function modifyReward(
    FurLib.Furball calldata furball,
    FurLib.RewardModifiers memory modifiers,
    FurLib.Account calldata account,
    bool contextual
  ) external view returns(FurLib.RewardModifiers memory) {
    if (contextual) {
      if (furball.zone >= 0x10000) {
        // Battle zone always zero FUR now with TK
        modifiers.furPercent = 0;
      } else {
        // In explore (exp), we need to adjust for prior EXP collections
        LastGain memory last = lastGain[furball.number];
        if (last.timestamp > furball.last) {
          uint remains = block.timestamp - last.timestamp;
          uint total = block.timestamp - furball.last;
          modifiers.expPercent = uint16(modifiers.expPercent * remains / total);
          modifiers.luckPercent = uint16(modifiers.luckPercent * remains / total);
        }
      }
    }

    return modifiers;
  }

  /// @notice Hook for zone change
  /// @dev When a furball changes zone, we need to clear the lastGain timestamp
  function enterZone(uint256 tokenId, uint32 zone) external {
    uint32 furballNumber = tokenToNumber[tokenId];
    if (furballNumber > 0) {
      lastGain[furballNumber].timestamp = 0;
      lastGain[furballNumber].experience = 0;
    }
  }

  /// @notice OpenSea metadata
  function attributesMetadata(
    FurLib.FurballStats calldata stats, uint32 maxExperience
  ) external view returns(bytes memory) {
    return MetaData.traitValue("Level", FurLib.expToLevel(
      stats.definition.experience + lastGain[stats.definition.number].experience, maxExperience
    ));
  }

  /// @notice Proxy can be set to an arbitrary address to represent the allowed offline job
  function setJobAddress(address addr) external gameAdmin {
    _job = addr;
  }

  /// @notice Simple proxy allowed check
  modifier allowedProxy() {
    require(msg.sender == _job || furballs.isAdmin(msg.sender), "FPRXY");
    _;
  }
}
