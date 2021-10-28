// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

// import "./FurLib.sol";
// import "hardhat/console.sol";

/// @title Exp
/// @author LFG Gaming LLC
/// @notice Math utility functions for balance equations
abstract contract Exp {
  /// @notice Calculates current level based upon EXP
  /// @dev Levels are triangular numbers; this function reverses the equation.
  function expToLevel(uint32 exp, uint32 maxExp) public pure returns(uint16) {
    return _sqrt(_exp(exp > maxExp ? maxExp : exp));
  }

  /// @notice Converts exp into a sqrt-able number.
  function _exp(uint32 exp) internal pure returns(uint32) {
    return exp < 100 ? 0 : ((exp + exp - 100) / 100);
  }

  /// @notice Simple square root function using the Babylonian method
  function _sqrt(uint32 x) internal pure returns(uint16) {
    if (x < 1) return 0;
    if (x < 4) return 1;
    uint z = (x + 1) / 2;
    uint y = x;
    while (z < y) {
      y = z;
      z = (x / z + z) / 2;
    }
    return uint16(y);
  }
}
