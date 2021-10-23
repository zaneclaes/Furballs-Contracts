// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

/// @title FurLib
/// @author LFG Gaming LLC
/// @notice Utilities for Furballs
library FurLib {
  // Key data structure given to clients for high-level furball access (furballs.stats)
  struct FurballStats {
    uint32 expRate;
    uint32 furRate;
    RewardModifiers modifiers;
    Furball definition;
    Snack[] snacks;
  }

  // The response from a single play session indicating rewards
  struct Rewards {
    uint64 duration;
    uint16 levels;
    uint32 experience;
    uint128 loot;
    uint256 fur;
  }

  // Stored data structure in Furballs master contract which keeps track of mutable data
  struct Furball {
    uint256 number;       // Overall number, starting with 1
    uint32 count;         // Index within the collection
    uint32 rarity;        // Total rarity score for later boosts
    uint32 experience;    // EXP
    uint32 zone;          // When exploring, the zone number. Otherwise, battling.
    uint16 level;         // Current EXP => level; can change based on level up during collect
    uint64 last;          // Timestamp of last action (battle/explore)
    uint64 birth;         // Timestamp of furball creation
    uint64 trade;         // Timestamp of last furball trading wallets
    uint256[] inventory;  // IDs of items in inventory
  }

  // A runtime-calculated set of properties that can affect Furball production during collect()
  struct RewardModifiers {
    uint32 expPercent;
    uint32 furPercent;
    uint32 luckPercent;
    uint32 happinessPoints;
    uint32 energyPoints;
    uint32 zone;
    uint16 weight;        // Inventory size
    uint16 level;         // Starting level (at beginning of collection cycle)
  }

  // For sale via loot engine.
  struct Snack {
    uint32 snackId;       // Unique ID
    uint32 duration;      // Time it lasts, seconds
    uint32 furCost;       // How much FUR
    uint16 happiness;     // +happiness bost points
    uint16 energy;        // +energy boost points
    uint32 count;         // How many in stack?
    uint64 fed;           // When was it fed (if it is active)?
  }

  uint32 public constant Max32 = type(uint32).max;

  uint32 public constant EXP_PER_INTERVAL = 500;
  uint32 public constant FUR_PER_INTERVAL = 10;

  uint256 public constant OnePercent = 1000;
  uint256 public constant OneHundredPercent = 100000;

  function trait(string memory traitType, string memory value) internal pure returns (bytes memory) {
    return abi.encodePacked('{"trait_type": "', traitType,'", "value": "', value, '"}, ');
  }

  function traitValue(string memory traitType, uint256 value) internal pure returns (bytes memory) {
    return abi.encodePacked('{"trait_type": "', traitType,'", "value": ', uint2str(value), '}, ');
  }

  function traitNumber(
    string memory traitType, uint8 displayType, uint256 value
  ) internal pure returns (bytes memory) {
    return abi.encodePacked('{"trait_type": "', traitType,
      '", "display_type": "',
      (displayType == 0 ? 'number' : 'boost_percentage'),
      '", "value": ', uint2str(value), '}, ');
  }

  function extractByte(uint256 tokenId, uint8 byteNum) internal pure returns(uint8) {
    return uint8((tokenId / (256 ** uint256(byteNum))) % 256);
  }

  function isBattleZone(uint32 zone) internal pure returns(bool) {
    return zone >= 0x10000;
  }

  function bytesHex(bytes memory data) internal pure returns(string memory) {
    bytes memory alphabet = "0123456789abcdef";

    bytes memory str = new bytes(2 + data.length * 2);
    str[0] = "0";
    str[1] = "x";
    for (uint i = 0; i < data.length; i++) {
        str[2+i*2] = alphabet[uint(uint8(data[i] >> 4))];
        str[3+i*2] = alphabet[uint(uint8(data[i] & 0x0f))];
    }
    return string(str);
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
      return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
      len++;
      j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len;
    while (_i != 0) {
      k = k-1;
      uint8 temp = (48 + uint8(_i - _i / 10 * 10));
      bytes1 b1 = bytes1(temp);
      bstr[k] = b1;
      _i /= 10;
    }
    return string(bstr);
  }

  function encode(bytes memory data) internal pure returns (string memory) {
    if (data.length == 0) return "";

    string memory table = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    uint256 encodedLen = 4 * ((data.length + 2) / 3);
    string memory result = new string(encodedLen + 32);

    assembly {
      mstore(result, encodedLen)
      let tablePtr := add(table, 1)

      let dataPtr := data
      let endPtr := add(dataPtr, mload(data))
      let resultPtr := add(result, 32)

      for {

      } lt(dataPtr, endPtr) {

      } {
        dataPtr := add(dataPtr, 3)
        let input := mload(dataPtr)
        mstore(
          resultPtr,
          shl(248, mload(add(tablePtr, and(shr(18, input), 0x3F))))
        )
        resultPtr := add(resultPtr, 1)
        mstore(
          resultPtr,
          shl(248, mload(add(tablePtr, and(shr(12, input), 0x3F))))
        )
        resultPtr := add(resultPtr, 1)
        mstore(
          resultPtr,
          shl(248, mload(add(tablePtr, and(shr(6, input), 0x3F))))
        )
        resultPtr := add(resultPtr, 1)
        mstore(
          resultPtr,
          shl(248, mload(add(tablePtr, and(input, 0x3F))))
        )
        resultPtr := add(resultPtr, 1)
      }

      switch mod(mload(data), 3)
      case 1 {
        mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
      }
      case 2 {
        mstore(sub(resultPtr, 1), shl(248, 0x3d))
      }
    }

    return result;
  }
}
