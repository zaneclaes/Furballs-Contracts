// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./IZone.sol";
import "../utils/FurProxy.sol";

/// @title Zone
/// @author LFG Gaming LLC
/// @notice An abstract implementation of zone
abstract contract Zone is IZone, FurProxy {
  uint32 private immutable _ZONE;

  uint private _cost = 2200000000000000 wei;

  constructor(address furballsAddress, uint32 zone) FurProxy(furballsAddress) {
    _ZONE = zone;
  }

  /// @notice Number for this zone
  function getZoneNumber() external virtual override view returns(uint) {
    return _ZONE;
  }

  /// @notice Cost to perform actions in this zone
  function getCost() external virtual override view returns(uint) {
    return _cost;
  }

  /// @notice Cost can be changed for market conditions
  function setCost(uint cost) external gameAdmin {
    _cost = cost;
  }
}
