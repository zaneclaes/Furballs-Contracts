// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./ZoneLib.sol";

/// @title IZone
/// @author LFG Gaming LLC
/// @notice A more complicated zone definition
interface IZone {
  /// @notice How much do actions cost in this zone?
  function getCost() external view returns(uint);

  /// @notice Simple reference to zone number
  function getZoneNumber() external view returns(uint);
}
