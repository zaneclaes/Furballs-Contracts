// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./FurballEdition.sol";
import "../utils/FurLib.sol";
import "hardhat/console.sol";

/// @title Edition1
/// @author LFG Gaming LLC
/// @notice Concrete implentation of the first Furball edition
contract Edition1 is FurballEdition {
  uint16 public override maxCount = 7500;
  uint16 public override maxAdoptable = 2500;

  constructor(address fa, address paletteAddress, address[] memory pa, address[] memory pathsAddresses)
    FurballEdition(fa, paletteAddress, pa, pathsAddresses) { }

  function maxMintable(address addr) external virtual override view returns(uint16) {
    bool withFur = count >= maxAdoptable;
    if (furballs.isAdmin(addr)) {
      return withFur ? 75 : 50;
    }
    bool live = liveAt != 0 && liveAt <= uint64(block.timestamp);
    uint16 min = live ? (withFur ? 9 : 5) : 0;
    return _whitelist[addr] > min ? _whitelist[addr] : min;
  }

  function purchaseFur() public override view returns(uint256) {
    if (count < maxAdoptable) return 0;
    if (count < (maxAdoptable + 1000)) return  40000;
    if (count < (maxAdoptable + 2000)) return  80000;
    if (count < (maxAdoptable + 3000)) return 160000;
    if (count < (maxAdoptable + 4000)) return 320000;
    if (count < (maxAdoptable + 4750)) return 640000;
    if (count < (maxAdoptable + 4800)) return 10000000;
    if (count < (maxAdoptable + 4900)) return 100000000;
    return 1000000000;
  }
}
