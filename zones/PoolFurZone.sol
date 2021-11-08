// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./Zone.sol";
// import "./IZone.sol";
import "./ZoneLib.sol";

/// @title PoolFurZone
/// @author LFG Gaming LLC
/// @notice The first pooling zone, a simple FUR implementation
contract PoolFurZone is Zone {
  constructor(address furballsAddress) Zone(furballsAddress, 0x10001) {}
}
