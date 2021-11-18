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

  // All zone changes from a round, executed at once
  mapping(uint32 => uint256[]) private _pendingZones;

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
      require(errorCode == 0, errorCode == 0 ? "" : string(abi.encodePacked(
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
    if (tkRequest.mintCount > 0) {
      // Edition is one-indexed, to allow for null
      address[] memory to = new address[](tkRequest.mintCount);
      for (uint i=0; i<tkRequest.mintCount; i++) {
        to[i] = tkRequest.sender;
      }

      // "Gift" the mint (FUR purchase should have been done above)
      furballs.mint(to, tkRequest.mintEdition, address(this));
    }

    // Change zonens happens at the very end of the turn, so buffs can take effect
    if (tkRequest.movements.length > 1) {
      _changeZones(tkRequest.movements, tkRequest.sender);
    }

    return 0; // no error
  }

  /// @notice Validate a timekeeper request
  function _validateTimekeeper(
    L2Lib.TimekeeperRequest memory tkRequest,
    bytes memory signature
  ) internal view returns (uint) {
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
      keccak256("TimekeeperRequest(address sender,uint32 fuel,uint32 fur_gained,uint32 fur_spent,uint8 mint_edition,uint8 mint_count,uint64 deadline)"),
      tkRequest.sender,
      tkRequest.tickets,
      tkRequest.furGained,
      tkRequest.furSpent,
      tkRequest.mintEdition,
      tkRequest.mintCount,
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
      if (tokenToNumber[round.tokenId] == 0) {
        tokenToNumber[round.tokenId] = round.number;
      }
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

    // And give away snacks (FUR spending done separately)
    for (uint i=0; i<round.snackStacks.length; i++) {
      uint64 stack = round.snackStacks[i];
      furballs.fur().giveSnack(round.tokenId, uint32(stack >> 16), uint16(stack));
    }
  }

  /// @notice An array of "movements" can move many furballs at once.
  function _changeZones(uint256[] memory movements, address sender) internal {
    uint temp = movements[0];
    uint8 numFurballs = uint8(temp);
    uint32 zone = uint32(temp >> 8);
    uint256[] memory tokenIds = new uint256[](numFurballs);
    uint fbIdx = 0;

    for (uint i=1; i<movements.length; i++) {
      if (movements[i] < 0x1000000) {
        // furballs.playMany(tokenIds, zone, address(this));
        temp = movements[i];
        numFurballs = uint8(temp);
        zone = uint32(temp >> 8);
        tokenIds = new uint256[](numFurballs);
        fbIdx = 0;
      } else {
        tokenIds[fbIdx] = movements[i];
        fbIdx = fbIdx + 1;
      }
    }

    furballs.playMany(tokenIds, zone, address(this));
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
    FurLib.Furball memory furball = stats.definition;
    uint level = furball.level;

    if (furball.zone < 0x10000) {
      // When in explore, we check if TK has accrued more experience for this furball
      LastGain memory last = lastGain[furball.number];
      if (last.timestamp > furball.last) {
        level = FurLib.expToLevel(
          furball.experience + lastGain[stats.definition.number].experience, maxExperience
        );
      }
    }

    return MetaData.traitValue("Level", level);
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
