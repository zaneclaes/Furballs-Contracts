// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

/// @title IFurballsPaths
/// @author LFG Gaming LLC
/// @notice Renders SVG d-paths
interface IFurballPaths {
  function path(uint8 p) external pure returns(bytes memory);
}
