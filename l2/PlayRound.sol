// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.6;

// import "./IPlayRound.sol";

// /// @title PlayRound
// /// @author LFG Gaming LLC
// /// @notice A "round" of play (like a block) to be executed by miners
// abstract contract PlayRound is IPlayRound {
//   /// @notice Create a signature object for later unpacking
//   function signMove(
//     bytes calldata signature, uint64 deadline
//   ) virtual internal returns(L2Lib.MoveSig memory) {
//     require(signature.length > 0, 'SIG');
//     require(deadline > block.timestamp, 'TS');
//     return L2Lib.MoveSig(signature, deadline, msg.sender);
//   }
// }
