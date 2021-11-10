// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.6;

// import "./PlayRound.sol";
// import "./L2Lib.sol";

// /// @title TestRound
// /// @author LFG Gaming LLC
// /// @notice Bypasses restrictions; for testing or batching.
// contract TestRound is PlayRound {
//   L2Lib.PoolReward[] private _rewards;

//   function addReward(L2Lib.PoolReward calldata reward) external {
//     _rewards.push(reward);
//   }

//   function rewards() external virtual override view returns (L2Lib.PoolReward[] memory) {
//     return _rewards;
//   }
// }
