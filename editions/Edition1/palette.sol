// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPalette.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1palette is IFurballPalette {
  function numPalettes() external override pure returns(uint8) {
    return 29;
  }

  function primaryColor(uint8 p) external override pure returns(string memory) {
    if (p == 0) return "97c7cf";
    if (p == 1) return "f0e7ea";
    if (p == 2) return "c6c6ff";
    if (p == 3) return "dd9962";
    if (p == 4) return "ffdd5e";
    if (p == 5) return "FF96E5";
    if (p == 6) return "65e8fb";
    if (p == 7) return "FFB569";
    if (p == 8) return "70737c";
    if (p == 9) return "afe39d";
    if (p == 10) return "f2Dbbd";
    if (p == 11) return "f2afa4";
    if (p == 12) return "f2a3c8";
    if (p == 13) return "cea393";
    if (p == 14) return "B594F2";
    if (p == 15) return "6cc4cf";
    if (p == 16) return "84b5ff";
    if (p == 17) return "e3eefc";
    if (p == 18) return "81DE91";
    if (p == 19) return "c9b5a3";
    if (p == 20) return "e9af6e";
    if (p == 21) return "edeae4";
    if (p == 22) return "966548";
    if (p == 23) return "95a72f";
    if (p == 24) return "ffb0ff";
    if (p == 25) return "ff6b6c";
    if (p == 26) return "E0AE45";
    if (p == 27) return "ebe4d8";
    if (p == 28) return "b4ffc6";
    require(false, 'PALETTE');
  }

  function secondaryColor(uint8 p) external override pure returns(string memory) {
    if (p == 0) return "63a8b5";
    if (p == 1) return "f4d6fd";
    if (p == 2) return "ffc9fd";
    if (p == 3) return "f5d0b3";
    if (p == 4) return "FFF2BD";
    if (p == 5) return "FFC7EB";
    if (p == 6) return "c1f3fb";
    if (p == 7) return "FFDA99";
    if (p == 8) return "a4a9b5";
    if (p == 9) return "d4ffc5";
    if (p == 10) return "fff6ec";
    if (p == 11) return "f2d4bf";
    if (p == 12) return "f2cee4";
    if (p == 13) return "f0d2c7";
    if (p == 14) return "DAC7FF";
    if (p == 15) return "e9bbf2";
    if (p == 16) return "ffefc2";
    if (p == 17) return "bfcffa";
    if (p == 18) return "B9EDC0";
    if (p == 19) return "e8dcd1";
    if (p == 20) return "fdd8b0";
    if (p == 21) return "d1cec6";
    if (p == 22) return "BF9276";
    if (p == 23) return "c6d55c";
    if (p == 24) return "ffcf80";
    if (p == 25) return "ff9c9c";
    if (p == 26) return "F7D280";
    if (p == 27) return "E3DC9C";
    if (p == 28) return "e8ff9c";
    require(false, 'PALETTE');
  }

  function numBackgroundColors() external override pure returns(uint8) {
    return 10;
  }

  function backgroundColor(uint8 i) external override pure returns(string memory) {
    if (i == 0) return "90fdd9";
    if (i == 1) return "afffab";
    if (i == 2) return "ffef8c";
    if (i == 3) return "ffce9c";
    if (i == 4) return "fdcbc8";
    if (i == 5) return "ffc7f3";
    if (i == 6) return "d0d0fd";
    if (i == 7) return "95c5ff";
    if (i == 8) return "c6edff";
    if (i == 9) return "9ffffc";
    require(false, 'BACKGROUND');
  }
}