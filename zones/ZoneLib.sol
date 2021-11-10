// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

// import "../utils/FurLib.sol";

/// @title ZoneLib
/// @author LFG Gaming LLC
/// @notice Utilities for zones
library ZoneLib {
  // Consumable by Furgreement to assign rewards
  struct ZoneReward {
    uint32 fur;
  }

  /// @notice Checks if this is a pool zone, returning the pool type
  function poolZone(uint32 zone) internal pure returns(uint256) {
    if (zone < 0x10000) return 0;
    return (zone / 0x10000) + 1;
  }
}
