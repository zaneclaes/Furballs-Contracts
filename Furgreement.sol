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

/// @title Furgreement
/// @author LFG Gaming LLC
/// @notice L2 proxy authority; has permissions to write to main contract(s)
contract Furgreement is EIP712, FurProxy {
  // Tracker of wallet balances
  Fuel public fuel;

  // Simple, fast check for a single allowed proxy...
  address private _job;

  // Simple, fast check for a single allowed proxy...
  mapping(uint32 => uint64) private _lastAction;

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
      require(errorCode == 0, FurLib.uint2str(errorCode));
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
    if (tkRequest.rounds.length > 0) {
      _resolveRounds(tkRequest.rounds, tkRequest.sender);
    }

    // Mint new furballs from an edition
    if (tkRequest.mintEdition > 0) {
      // Edition is one-indexed, to allow for null
      address[] memory to = new address[](1);
      to[0] = tkRequest.sender;

      // "Gift" the mint (FUR purchase should have been done above)
      furballs.mint(to, tkRequest.mintEdition - 1, address(this));
    }

    // Change zonens happens at the very end of the turn, so buffs can take effect
    if (tkRequest.movements.length > 1) {
      _changeZones(tkRequest.movements, tkRequest.sender);
    }

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
  function _resolveRounds(L2Lib.RoundResolution[] memory rounds, address sender) internal {
    for (uint i=0; i<rounds.length; i++) {
      if (rounds[i].expGained > 0) {
        // EXP gain (in explore mode)
        _lastAction[rounds[i].number] = uint64(block.timestamp);
      }

      if (rounds[i].items.length != 0) {
        // First item is an optional drop
        if (rounds[i].items[0] != 0)
          furballs.drop(rounds[i].tokenId, rounds[i].items[0], 1);

        // Other items are pickups
        for (uint j=1; j<rounds[i].items.length; j++) {
          furballs.pickup(rounds[i].tokenId, rounds[i].items[j]);
        }
      }

      // And purchase snacks
      if (rounds[i].snackStacks.length != 0) {
        _purchaseSnacks(rounds[i].snackStacks, rounds[i].tokenId);
      }
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
        furballs.playMany(tokenIds, zone, sender);
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

    furballs.playMany(tokenIds, zone, sender);
  }

  /// @notice Purchase snacks from the EIP712
  function _purchaseSnacks(uint64[] memory snacks, uint256 tokenId) internal {
    for (uint i=0; i<snacks.length; i++) {
      uint32 snackId = uint32(snacks[i] >> 16);
      uint16 count = uint16(snacks[i] & 0xFFFF);

      // Snacks are purchased as a "gift" because the FUR will be expended later.
      furballs.fur().purchaseSnack(address(this), FurLib.PERMISSION_CONTRACT, tokenId, snackId, count);
    }
  }

  /// @notice The furgreement can modify rewards
  function modifyReward(
    FurLib.Furball calldata furball,
    FurLib.RewardModifiers memory modifiers,
    FurLib.Account calldata account,
    bool contextual
  ) external view returns(FurLib.RewardModifiers memory) {
    // if (contextual) {
    //   if (furball.zone >= 0x10000) {
    //     // Battle zone always zero FUR now with TK
    //     modifiers.furPercent = 0;
    //   } else {

    //   }
    //   uint64 tkLast = _lastAction[furball.number];
    //   if (tkLast > furball.last) {
    //     modifiers.furPercent = 0;
    //     modifiers.expPercent = 0;
    //     modifiers.luckPercent = 0;
    //   }
    // }

    return modifiers;
  }

  /// @notice OpenSea metadata
  function attributesMetadata(
    FurLib.FurballStats calldata stats
  ) external view returns(bytes memory) {
    return MetaData.traitValue("Level", stats.definition.level);
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
