// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../utils/FurLib.sol";
import "../utils/FurProxy.sol";
import "../utils/MetaData.sol";
import "./ZoneLib.sol";

/// @title Zones
/// @author LFG Gaming LLC
/// @notice Zone management (overrides) for Furballs
contract Zones is FurProxy {
  mapping(uint32 => ZoneLib.ZoneModifier) private modifiers;

  // Names of zones
  mapping(uint32 => string) public names;

  // Background (SVGs) for Zones
  mapping(uint32 => string) public backgrounds;

  // Override of tokenId => zoneNum
  mapping(uint256 => uint32) private furballZones;

  // Simple reverse lookup
  mapping(uint32 => uint256) public furballNumberToTokenId;
  mapping(uint256 => uint32) private tokenIdToFurballNumber;

  // Internal tracker for a furball when gaining in the zone
  struct LastGain {
    uint32 total;
    uint32 experience;
    uint64 timestamp;
  }

  // Tightly packed EXP gain + timestamp
  mapping(uint256 => LastGain) public lastGain;

  constructor(address furballsAddress) FurProxy(furballsAddress) { }

  function setZone(
    uint32 zoneNum, string calldata name, string calldata background, ZoneLib.ZoneModifier calldata mods
  ) external gameAdmin {
    require(bytes(name).length > 0, "NAME");
    // bool isNew = bytes(zoneNames[zoneNum]).length == 0;
    modifiers[zoneNum] = mods;
    names[zoneNum] = name;
    backgrounds[zoneNum] = background;
  }

  /// @notice Lookup of real zone number (using overrides)
  function getZoneNumber(uint32 furballNumber, uint32 defaultZone) external returns(uint32) {
    uint256 tokenId = furballNumberToTokenId[furballNumber];
    return (tokenId == 0) ? defaultZone : furballZones[tokenId];
  }

  /// @notice When a furball earns EXP via Timekeeper
  function addExp(uint256 tokenId, uint32 exp) external gameAdmin {
    lastGain[tokenId].timestamp = uint64(block.timestamp);
    lastGain[tokenId].experience = exp;
  }

  /// @notice Stats for a zone
  function getModifier(uint32 zoneNum) external view returns(ZoneLib.ZoneModifier memory) {
    return modifiers[zoneNum];
  }

  /// @notice Public display (OpenSea, etc.)
  function getName(uint32 zoneNum) public view returns(string memory) {
    return _zoneName(zoneNum);
  }

  /// @notice Zones can have unique background SVGs
  function getBackgroundSvg(uint256 tokenId) external view returns(string memory) {
    return backgrounds[furballZones[tokenId]];
  }

  /// @notice OpenSea metadata
  function attributesMetadata(
    FurLib.FurballStats calldata stats, uint256 tokenId, uint32 maxExperience
  ) external view returns(bytes memory) {
    FurLib.Furball memory furball = stats.definition;
    uint level = furball.level;
    uint32 zoneNum = furballZones[tokenId];
    if (zoneNum == 0) zoneNum = furball.zone;

    if (furball.zone < 0x10000) {
      // When in explore, we check if TK has accrued more experience for this furball
      LastGain memory last = lastGain[tokenId];
      if (last.timestamp > furball.last) {
        level = FurLib.expToLevel(furball.experience + lastGain[tokenId].experience, maxExperience);
      }
    }

    return abi.encodePacked(
      MetaData.traitValue("Level", level),
      MetaData.trait("Zone", _zoneName(zoneNum))
    );
  }

  /// @notice Hook for zone change
  function enterZone(uint256 tokenId, uint32 zone) external returns (uint256) {
    _enterZone(tokenId, zone);
    return zone;
  }

  /// @notice Allow TK to override a zone
  function overrideZone(uint256[] calldata tokenIds, uint32 zone) external {
    for (uint i=0; i<tokenIds.length; i++) {
      _enterZone(tokenIds[i], zone);
    }
  }

  /// @notice Caches ID/number as a byproduct
  /// @dev When a furball changes zone, we need to clear the lastGain timestamp
  function _enterZone(uint256 tokenId, uint32 zone) internal {
    lastGain[tokenId].timestamp = 0;
    lastGain[tokenId].experience = 0;
    furballZones[tokenId] = zone;
    _cacheFurballNumber(tokenId);
  }

  /// @notice Caches a mapping so we can get from furball num => ID
  function _cacheFurballNumber(uint256 tokenId) internal {
    if (tokenIdToFurballNumber[tokenId] != 0) return;
    FurLib.FurballStats memory stats = furballs.stats(tokenId, true);
    uint32 number = stats.definition.number;
    tokenIdToFurballNumber[tokenId] = number;
    furballNumberToTokenId[number] = tokenId;
  }

  /// @notice Public display (OpenSea, etc.)
  function _zoneName(uint32 zoneNum) internal view returns(string memory) {
    if (zoneNum == 0) return "Explore";
    if (zoneNum == 0x10000) return "Battle";
    return names[zoneNum];
  }

  // /// @notice Lets game/admin change the cost to enter the zone
  // function setZone(address zoneAddr) external gameAdmin {
  //   IZone zone = IZone(zoneAddr);
  //   uint32 zoneNum = uint32(zone.getZoneNumber());
  //   address existing = address(zones[zoneNum]);

  //   if (existing == address(0)) {
  //     zoneNumbers.push(zoneNum);
  //   }
  //   zones[zoneNum] = zone;
  // }

}
