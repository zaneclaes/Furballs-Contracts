// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

/// @title IFurballPalette
/// @author LFG Gaming LLC
/// @notice Contains all data about one part of the furball in a given edition
interface IFurballPalette {
  function numPalettes() external pure returns(uint8);
  function primaryColor(uint8 p) external pure returns(string memory);
  function secondaryColor(uint8 p) external pure returns(string memory);
  function numBackgroundColors() external pure returns(uint8);
  function backgroundColor(uint8 i) external pure returns(string memory);
}
