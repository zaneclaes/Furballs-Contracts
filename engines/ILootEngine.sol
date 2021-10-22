// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "../editions/IFurballEdition.sol";
import "../utils/FurLib.sol";

/// @title ILootEngine
/// @author LFG Gaming LLC
/// @notice The loot engine is patchable by replacing the Furballs' engine with a new version
interface ILootEngine is IERC165 {
  /// @notice Max experience (and thus max level) could grow over time
  function maxExperience() external view returns(uint32);

  /// @notice When a Furball comes back from exploration, potentially give it some loot.
  function dropLoot(uint32 intervals, FurLib.RewardModifiers memory mods) external returns(uint256);

  /// @notice Players can pay to re-roll their loot drop on a Furball
  function upgradeLoot(uint256 item, uint32 badLuck) external returns(uint256);

  /// @notice Some zones may have preconditions
  function enterZone(uint256 tokenId, uint32 zone, uint256[] memory team) external returns(uint256);

  /// @notice Calculates the effects of the loot in a Furball's inventory
  function modifyReward(
    FurLib.RewardModifiers memory baseModifiers,
    uint32 teamSize,
    uint256[] memory inventory
  ) external view returns(FurLib.RewardModifiers memory);

  /// @notice JSON object for displaying metadata on OpenSea, etc.
  function renderAttributes(uint8 editionIndex, FurLib.FurballStats memory stats) external view returns(bytes memory);

  /// @notice Get a potential snack for the furball by its ID
  function getSnack(uint32 snack) external view returns(FurLib.Snack memory);

  /// @notice Proxy registries are allowed to act as 3rd party trading platforms
  function canProxyTrades(address owner, address operator) external view returns(bool);

  /// @notice Authorization mechanics are upgradeable to account for security patches
  function approveSender(address sender) external view returns(address);

  /// @notice Called when a Furball is traded to update delegate logic
  function onTrade(address from, address to, uint256 tokenId) external;
}
