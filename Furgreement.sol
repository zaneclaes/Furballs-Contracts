// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "./Fur.sol";
import "./utils/FurProxy.sol";
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

  /// Loot changes on a token for resolve function
  struct LootResolution {
    uint256 tokenId;
    uint128 itemGained;
    uint128 itemLost;
  }

  constructor(
    address furballsAddress, address fuelAddress
  ) EIP712("Furgreement", "1") FurProxy(furballsAddress) {
    fuel = Fuel(fuelAddress);
    _job = msg.sender;
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

  /// @notice L2 payout
  /// @dev Triggered by off-chain batch job
  function resolveFur(
    uint32[] calldata furAmounts,
    address[] calldata recipients
  ) external allowedProxy {
    for (uint i=0; i<recipients.length; i++) {
      furballs.fur().earn(recipients[i], furAmounts[i]);
    }
  }

  /// @notice L2 payout
  /// @dev Triggered by off-chain batch job
  function resolveSnacks(
    FurLib.Feeding[] calldata feedings,
    address[] calldata owners
  ) external allowedProxy {
    for (uint i=0; i<feedings.length; i++) {
      furballs.fur().purchaseSnack(owners[i], FurLib.PERMISSION_USER,
        feedings[i].tokenId, feedings[i].snackId, feedings[i].count);
    }
  }

  /// @notice L2 loot drop/pickup
  /// @dev Triggered by off-chain batch job
  function resolveLoot(
    LootResolution[] calldata loots
  ) external allowedProxy {
    for (uint i=0; i<loots.length; i++) {
      // Drop first, to make space...
      if (loots[i].itemLost != 0) furballs.drop(loots[i].tokenId, loots[i].itemLost, 1);

      // Then pickup new loot
      if (loots[i].itemGained != 0) furballs.pickup(loots[i].tokenId, loots[i].itemGained);
    }
  }

  /// @notice Simple proxy allowed check
  modifier allowedProxy() {
    require(msg.sender == _job || furballs.isAdmin(msg.sender), "FPRXY");
    _;
  }
}
