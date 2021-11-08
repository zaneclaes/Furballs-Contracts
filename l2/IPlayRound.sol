// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./L2Lib.sol";

/// @title IPlayRound
/// @author LFG Gaming LLC
/// @notice A "round" of play (like a block, in chain parlance) to be executed by miners
interface IPlayRound {
  /// @notice What are the player addresses in this round?
  function rewards() external view returns (L2Lib.PoolReward[] memory);
}
