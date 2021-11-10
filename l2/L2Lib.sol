// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../utils/FurLib.sol";

/// @title L2Lib
/// @author LFG Gaming LLC
/// @notice Utilities for L2
library L2Lib {

  // Payload for EIP-712 signature
  struct OAuthToken {
    address owner;
    uint32 access;
    uint64 deadline;
    bytes signature;
  }

  // // Play = collect / move zones
  // struct ActionPlay {
  //   uint256[] tokenIds;
  //   uint32 zone;
  // }

  // // Snack = FurLib.Feeding

  // // Loot (upgrade)
  // struct ActionUpgrade {
  //   uint256 tokenId;
  //   uint128 lootId;
  //   uint8 chances;
  // }

  // // Signature package that accompanies moves
  // struct MoveSig {
  //   bytes signature;
  //   uint64 deadline;
  //   address actor;
  // }

  // // Signature + play actions
  // struct SignedPlayMove {
  //   bytes signature;
  //   uint64 deadline;
  //   // address actor;
  //   uint32 zone;
  //   uint256[] tokenIds;
  // }

  // // What does a player earn from pool?
  // struct PoolReward {
  //   address actor;
  //   uint32 fur;
  // }
}
