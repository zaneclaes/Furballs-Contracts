// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

/// @title IFurballsPart
/// @author LFG Gaming LLC
/// @notice Contains all data about one part of the furball in a given edition
interface IFurballPart {
  function slot() external pure returns(string memory);
  function count() external pure returns(uint8);
  function options(uint8 rarity) external view returns(uint8[] memory);
  function name(uint8 idx) external pure returns(string memory);
  function data() external pure returns(bytes memory);
}
