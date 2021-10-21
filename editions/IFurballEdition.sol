// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../utils/FurLib.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/// @title IFurballEdition
/// @author LFG Gaming LLC
/// @notice Interface for a single edition within Furballs
interface IFurballEdition is IERC165 {
  function count() external view returns(uint32);
  function maxCount() external view returns (uint32); // total max count in this edition
  function addCount(address to, uint32 amount) external returns(bool);

  function numSlots() external view returns(uint8);
  function numParts(uint8 slot) external view returns(uint8);

  function live() external view returns(bool);
  function minted(address addr) external view returns(uint32);
  function maxMintable(address addr) external view returns(uint32);

  function purchaseFur() external view returns(uint256); // amount of fur to buy
  function maxAdoptable() external view returns (uint32); // how many can be adopted, out of the max?

  function spawn() external returns (uint256);

  /// @notice Calculates the effects of the loot in a Furball's inventory
  function getRewardModifiers(uint256 tokenId, uint16 level, uint32 zone) external view returns(FurLib.RewardModifiers memory);

  function tokenData(uint256 tokenId, uint256 number, uint64 birth, bytes memory attributes) external view returns(bytes memory);
}
