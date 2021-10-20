// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./FurballEdition.sol";
import "../utils/FurLib.sol";
import "hardhat/console.sol";

/// @title Edition1
/// @author LFG Gaming LLC
/// @notice Concrete implentation of the first Furball edition
contract Edition1 is FurballEdition {
  uint32 public override maxCount = 7500;
  uint32 public override maxAdoptable = 2500;

  constructor(address fa, address paletteAddress, address[] memory pa, address[] memory pathsAddresses)
    FurballEdition(fa, paletteAddress, pa, pathsAddresses) { }

  function maxMintable(address addr) external virtual override view returns(uint32) {
    bool withFur = count >= maxAdoptable;
    if (furballs.isAdmin(addr)) {
      return withFur ? 75 : 50;
    }
    if (!live) {
      return _whitelist[addr];
    }
    return withFur ? 15 : 5;
  }

  function purchaseFur() public override view returns(uint256) {
    if (count < maxAdoptable) return 0;
    if (count < (maxAdoptable + 1000)) return  2000;
    if (count < (maxAdoptable + 2000)) return  4000;
    if (count < (maxAdoptable + 3000)) return  8000;
    if (count < (maxAdoptable + 4000)) return 16000;
    return 32000;
  }
}
