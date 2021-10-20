// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "hardhat/console.sol";
import "../Furballs.sol";
import "./Leaderboard.sol";

contract Leaderboards {
  Furballs public furballs;

  mapping(string => Leaderboard) public leaderboards;

  string[] public keys;

  constructor(address furballsAddress) {
    furballs = Furballs(payable(furballsAddress));
  }

  /// @notice Adds a score to a leaderboard
  /// @param addr The wallet which earned the score
  /// @param stat The type of stat, e.g., exp/fur
  /// @param score The value which was earned
  function addScore(address addr, string memory stat, uint256 score) external onlyFurballs {
    bytes32 st = keccak256(bytes(stat));
    for (uint256 i=0; i<keys.length; i++) {
      string memory key = keys[i];
      if (keccak256(bytes(leaderboards[key].stat())) == st) {
        leaderboards[key].addScore(addr, score);
      }
    }
  }

  function addLeaderboards(address[] memory addr) external onlyAdmin {
    for (uint256 i=0; i<addr.length; i++) {
      require(addr[i] != address(0));
      Leaderboard leaderboard = Leaderboard(addr[i]);
      string memory key = leaderboard.key();
      if (!hasKey(key)) keys.push(key);
      leaderboards[leaderboard.key()] = leaderboard;
    }
  }

  function hasKey(string memory key) internal view returns(bool) {
    bytes32 k = keccak256(bytes(key));
    for (uint256 i=0; i<keys.length; i++) {
      if (k == keccak256(bytes(keys[i]))) {
        return true;
      }
    }
    return false;
  }

  modifier onlyAdmin() {
    require(furballs.isAdmin(msg.sender));
    _;
  }

  modifier onlyFurballs() {
    require(msg.sender == address(furballs));
    _;
  }
}
