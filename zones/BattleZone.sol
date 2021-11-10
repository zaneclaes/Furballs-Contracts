// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./Zone.sol";
// import "./IZone.sol";
import "./ZoneLib.sol";

/// @title BattleZone
/// @author LFG Gaming LLC
/// @notice The first pooling zone, a simple FUR implementation
contract BattleZone is Zone {
  constructor(address furballsAddress) Zone(furballsAddress, 0x10000) {}
}
