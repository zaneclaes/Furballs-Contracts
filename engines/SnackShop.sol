// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../utils/FurLib.sol";
import "../utils/FurProxy.sol";

/// @title SnackShop
/// @author LFG Gaming LLC
/// @notice Simple data-storage for snacks
contract SnackShop is FurProxy {
  // snackId to "definition" of the snack
  mapping(uint32 => FurLib.Snack) public snack;

  // List of actual snack IDs
  uint32[] public snackIds;

  constructor(address furballsAddress) FurProxy(furballsAddress) {
    _defineSnack(0x100, 24    ,  250, 15, 0);
    _defineSnack(0x200, 24 * 3,  750, 20, 0);
    _defineSnack(0x300, 24 * 7, 1500, 25, 0);
  }

  /// @notice Load a snack by ID
  function getSnack(uint32 snackId) external view returns(FurLib.Snack memory) {
    return snack[snackId];
  }

  /// @notice Allows admins to configure the snack store.
  function setSnack(
    uint32 snackId, uint32 duration, uint16 furCost, uint16 hap, uint16 en
  ) external gameAdmin {
    _defineSnack(snackId, duration, furCost, hap, en);
  }

  /// @notice Store a new snack definition
  function _defineSnack(
    uint32 snackId, uint32 duration, uint16 furCost, uint16 hap, uint16 en
  ) internal {
    if (snack[snackId].snackId != snackId) {
      snackIds.push(snackId);
    }

    snack[snackId].snackId = snackId;
    snack[snackId].duration = duration;
    snack[snackId].furCost = furCost;
    snack[snackId].happiness = hap;
    snack[snackId].energy = en;
    snack[snackId].count = 1;
    snack[snackId].fed = 0;
  }
}
