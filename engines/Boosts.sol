// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../utils/FurLib.sol";
import "../utils/FurProxy.sol";

/// @title Boosts
/// @author LFG Gaming LLC
/// @notice Handles pre-computation of stat boosts
contract Boosts is FurProxy {

  mapping(uint32 => uint16) private _numberRarity;

  constructor(address furballsAddress) FurProxy(furballsAddress) { }

  // -----------------------------------------------------------------------------------------------
  // Public
  // -----------------------------------------------------------------------------------------------

  function compute(uint32 furballNum, uint16 baseRarity) external gameAdmin {
    _compute(furballNum, baseRarity);
  }

  function rarityOf(uint32 furballNum) external view returns(uint256) {
    return _numberRarity[furballNum];
  }

  // -----------------------------------------------------------------------------------------------
  // internal
  // -----------------------------------------------------------------------------------------------

  function _compute(uint32 furballNum, uint16 rarity) internal {
    uint256 tokenId = furballs.tokenByIndex(furballNum - 1);
    if (uint8(tokenId) == 0) {
      if (FurLib.extractBytes(tokenId, 5, 1) == 6) rarity += 10; // Furdenza body
      if (FurLib.extractBytes(tokenId, 11, 1) == 12) rarity += 10; // Furdenza hoodie
    }
    _numberRarity[furballNum] = rarity;
  }
}
