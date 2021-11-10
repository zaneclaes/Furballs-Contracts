// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./IZone.sol";
import "../utils/FurProxy.sol";

/// @title Zones
/// @author LFG Gaming LLC
/// @notice A data storage of all the zones
abstract contract Zones is FurProxy {
  // Map the zone number to the index in the zones array + 1
  mapping(uint32 => IZone) public zones;

  // List of zones in above mapping
  uint[] public zoneNumbers;

  constructor(address furballsAddress) FurProxy(furballsAddress) { }

  /// @notice Public accessor to get a required zone
  function getZone(uint32 zoneNum) internal returns(IZone) {
    return _getZone(zoneNum);
  }

  /// @notice Lets game/admin change the cost to enter the zone
  function setZone(address zoneAddr) external gameAdmin {
    IZone zone = IZone(zoneAddr);
    uint32 zoneNum = uint32(zone.getZoneNumber());
    address existing = address(zones[zoneNum]);

    if (existing == address(0)) {
      zoneNumbers.push(zoneNum);
    }
    zones[zoneNum] = zone;
  }

  /// @notice Helper to load a required zone
  function _getZone(uint32 zoneNum) internal returns(IZone) {
    IZone zone = zones[zoneNum];
    require(address(zone) != address(0), 'ZONE');
    return zone;
  }
}
