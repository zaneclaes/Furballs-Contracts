// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

// import "./FurLib.sol";
// import "hardhat/console.sol";

/// @title Exp
/// @author LFG Gaming LLC
/// @notice Math utility functions that leverage storage and thus cannot be pure
abstract contract Exp {
  mapping(uint32 => uint16) _sqrts;

  /// @notice Calculates current level based upon EXP
  /// @dev Levels are triangular numbers; this function reverses the equation.
  function expToLevel(uint32 exp, uint32 maxExp) public view returns(uint16) {
    return sqrt(_exp(exp > maxExp ? maxExp : exp));
  }

  /// @notice This transaction caches sqrt values in the process
  function computeLevel(uint32 exp, uint32 maxExp) internal returns(uint16) {
    return computeSqrt(_exp(exp > maxExp ? maxExp : exp));
  }

  /// @notice a Square Root function that checks a lookup table first
  function sqrt(uint32 x) internal view returns(uint16) {
    if (x < 1) return 0;
    return _sqrts[x] > 0 ? _sqrts[x] : _sqrt(x);
  }

  /// @notice This *transaction* computes new sqrts if needed
  function computeSqrt(uint32 x) internal returns(uint16) {
    uint16 res = sqrt(x);
    if (res > 0 && _sqrts[x] == 0) {
      // console.log(FurLib.uint2str(x), FurLib.uint2str(res));
      _sqrts[x] = res;
    }
    return res;
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
