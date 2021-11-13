// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "./Fur.sol";
import "./utils/FurProxy.sol";
import "./l2/FurPayout.sol";
import "./l2/L2Lib.sol";
import "./l2/Fuel.sol";
import "./zones/IZone.sol";
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

  mapping(address => L2Lib.TimekeeperResult) public timekeeperResult;

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

      timekeeperResult[tkRequests[i].sender] =
        L2Lib.TimekeeperResult(uint64(block.timestamp), uint8(errorCode));

      require(errorCode == 0, FurLib.uint2str(errorCode));
    }
  }

  /// @notice Single Timekeeper run for one player; validates EIP-712 request
  function _runTimekeeper(
    L2Lib.TimekeeperRequest memory tkRequest,
    bytes memory signature
  ) internal returns (uint8) {
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

    Fur fur = furballs.fur();
    uint spentFuel = fuel.burn(tkRequest.sender, tkRequest.tickets);
    if (spentFuel < (tkRequest.tickets / 2)) return 10;

    if (tkRequest.furGained > 0) fur.earn(tkRequest.sender, tkRequest.furGained);
    if (tkRequest.furSpent > 0) {
      // Spend the FUR required for these actions
      fur.spend(tkRequest.sender, tkRequest.furSpent);

      if (tkRequest.mintEdition > 0) {
        // Edition is one-indexed, to allow for null
        address[] memory to = new address[](1);
        to[0] = tkRequest.sender;

        // "Gift" the mint (FUR purchase should have been done above)
        furballs.mint(to, tkRequest.mintEdition - 1, address(this));
      }

      // Each round represents a furball
      _resolveRounds(tkRequest.rounds, tkRequest.sender);

      // Change zonens happens at the very end of the turn, so buffs can take effect
      if (tkRequest.movements.length > 1) {
        _changeZones(tkRequest.movements, tkRequest.sender);
      }
    }

    return 0; // no error
  }

  /// @notice Give rewards/outcomes directly
  function _resolveRounds(L2Lib.RoundResolution[] memory rounds, address sender) internal {
    for (uint i=0; i<rounds.length; i++) {
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
    uint8 numFurballs = uint8(temp % 0x100);
    uint32 zone = uint32(temp / 100);
    uint256[] memory tokenIds = new uint256[](numFurballs);
    uint fbIdx = 0;

    for (uint i=1; i<movements.length; i++) {
      if (movements[i] < 0x1000000) {
        furballs.playMany(tokenIds, zone, sender);
        temp = movements[i];
        numFurballs = uint8(temp % 0x100);
        zone = uint32(temp / 100);
        tokenIds = new uint256[](numFurballs);
        fbIdx = 0;
      } else {
        tokenIds[fbIdx] = movements[i];
        fbIdx = fbIdx + 1;
      }
    }

    furballs.playMany(tokenIds, zone, sender);
  }

  function _purchaseSnacks(uint64[] memory snacks, uint256 tokenId) internal {
    for (uint i=0; i<snacks.length; i++) {
      uint32 snackId = uint32(snacks[i] / 0x10000);
      uint16 count = uint16(snacks[i] % 0x10000);

      // Snacks are purchased as a "gift" because the FUR will be expended later.
      furballs.fur().purchaseSnack(address(this), FurLib.PERMISSION_CONTRACT, tokenId, snackId, count);
    }
  }

  /// @notice The furgreement can modify rewards
  function modifyReward(
    FurLib.Furball memory furball,
    FurLib.RewardModifiers memory modifiers,
    FurLib.Account memory account,
    bool contextual
  ) external view returns(FurLib.RewardModifiers memory) {
    // If a pool zone, fur/loot are assigned previously
    if (contextual && ZoneLib.poolZone(furball.zone) > 0) {
      modifiers.furPercent = 0;
      modifiers.luckPercent = 0;
    }

    return modifiers;
  }

  /// @notice Proxy can be set to an arbitrary address to represent the allowed offline job
  function setJobAddress(address addr) external gameAdmin {
    _job = addr;
  }

  // /// @notice L2 payout
  // /// @dev Triggered by off-chain batch job
  // function resolveFur(
  //   uint32[] calldata furAmounts,
  //   address[] calldata recipients
  //   // address payout
  // ) external allowedProxy {
  //   // FurPayout po = FurPayout(payout);
  //   // (address[] memory recipients, uint32[] memory furAmounts) = po.fur();
  //   for (uint i=0; i<recipients.length; i++) {
  //     furballs.fur().earn(recipients[i], furAmounts[i]);
  //   }
  // }

  // /// @notice L2 payout
  // /// @dev Triggered by off-chain batch job
  // function resolveSnacks(
  //   FurLib.Feeding[] calldata feedings,
  //   address[] calldata owners
  // ) external allowedProxy {
  //   for (uint i=0; i<feedings.length; i++) {
  //     furballs.fur().purchaseSnack(owners[i], FurLib.PERMISSION_USER,
  //       feedings[i].tokenId, feedings[i].snackId, feedings[i].count);
  //   }
  // }

  // /// @notice L2 loot drop/pickup
  // /// @dev Triggered by off-chain batch job
  // function resolveLoot(
  //   L2Lib.LootResolution[] calldata loots
  // ) external allowedProxy {
  //   for (uint i=0; i<loots.length; i++) {
  //     // Drop first, to make space...
  //     if (loots[i].itemLost != 0) furballs.drop(loots[i].tokenId, loots[i].itemLost, 1);

  //     // Then pickup new loot
  //     if (loots[i].itemGained != 0) furballs.pickup(loots[i].tokenId, loots[i].itemGained);
  //   }
  // }


  /// @notice Simple proxy allowed check
  modifier allowedProxy() {
    require(msg.sender == _job || furballs.isAdmin(msg.sender), "FPRXY");
    _;
  }
}
