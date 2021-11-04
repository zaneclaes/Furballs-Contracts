// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./FurballEdition.sol";
import "../utils/FurLib.sol";
import "hardhat/console.sol";

/// @title Edition1
/// @author LFG Gaming LLC
/// @notice Concrete implentation of the first Furball edition
contract Edition1 is FurballEdition {
  uint private constant _maxCount = 7500;
  uint private constant _maxAdoptable = 2500;

  constructor(address fa, address paletteAddress, address[] memory pa, address[] memory pathsAddresses)
    FurballEdition(fa, paletteAddress, pa, pathsAddresses) { }

  function maxMintable(address addr) external virtual override view returns(uint16) {
    bool withFur = count >= _maxAdoptable;
    if (addr == furballs.owner()) return 500;
    if (furballs.isAdmin(addr)) return withFur ? 75 : 50;

    // Once the liveAt time is set, the public mint begins 1hr after launch.
    bool live = liveAt != 0 && liveAt <= uint64(block.timestamp);
    uint16 min = 0;
    uint16 whitelisted = uint16(_whitelist[addr]);

    if (live) {
      // When live, the general mintable is set
      min = withFur ? 15 : 5;
    } else if (liveAt > 3600 && (liveAt - 3600) <= uint64(block.timestamp)) {
      // Within the 1hr window before live; whitelist is closed
      whitelisted = 0;
    }

    return whitelisted > min ? whitelisted : min;
  }

  function maxCount() external override view returns (uint16) {
    return uint16(_maxCount);
  }

  function maxAdoptable() external override view returns (uint16) {
    return uint16(_maxAdoptable);
  }

  function purchaseFur() public override view returns(uint256) {
    unchecked {
      uint count_ = count;
      if (count_ < _maxAdoptable) return 0;
      if (count_ < (_maxAdoptable + 1000)) return  40000;
      if (count_ < (_maxAdoptable + 2000)) return  80000;
      if (count_ < (_maxAdoptable + 3000)) return 160000;
      if (count_ < (_maxAdoptable + 4000)) return 320000;
      if (count_ < (_maxAdoptable + 4750)) return 640000;
      if (count_ < (_maxAdoptable + 4900)) return 10000000;
      return 100000000;
    }
  }
}
