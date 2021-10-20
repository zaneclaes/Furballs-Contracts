// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "hardhat/console.sol";
import "../Furballs.sol";
import "../utils/FurLib.sol";

contract Leaderboard {
  Furballs public furballs;

  uint8 public size = 10;

  uint64 public interval;

  string public stat;

  string public key;

  event Reset();

  // Reset time => scores
  mapping(uint64 => mapping(address => uint256)) public allScores;

  // Reset time => scores
  mapping(uint64 => address[]) public topScores;

  // Reset time => scores
  mapping(uint64 => address[]) public scorers;

  mapping(uint64 => mapping(address => bool)) public hasScored;

  // Each time the board is reset
  uint64[] public resets;

  address private _admin;

  constructor(address furballsAddress, string memory statType, uint64 intervalTime, uint8 num) {
    _admin = msg.sender;
    furballs = Furballs(payable(furballsAddress));
    interval = intervalTime;
    stat = statType;
    size = num;
    key = string(abi.encodePacked(stat, "-", FurLib.uint2str(interval), "-", FurLib.uint2str(size)));
    _reset();
  }

  function addScore(address addr, uint256 score) public onlyFurballs {
    _resetIfNeeded();
    uint64 r = lastReset();
    allScores[r][addr] += score;

    if (!hasScored[r][addr]) {
      scorers[r].push(addr);
      hasScored[r][addr] = true;
    }

    uint256 len = topScores[r].length;
    if (len >= size && allScores[r][topScores[r][len - 1]] >= allScores[r][addr]) return;

    if (!_hasTopScore(r, addr)) {
      console.log('new score', allScores[r][addr]);
      topScores[r].push(addr);
    }
    _insertionSort(r);
    while (topScores[r].length > size) {
      topScores[r].pop();
    }
  }

  function numResets() public view returns(uint256) {
    return resets.length;
  }

  function getTop(uint64 reset) public view returns(address[] memory) {
    return topScores[reset];
  }

  function getCurrentScore(address addr) public view returns(uint256) {
    if (dueForReset()) return 0; // do not actually do the reset a view/getter
    return allScores[lastReset()][addr];
  }

  function dueForReset() public view returns(bool) {
    return interval > 0 && age() >= interval;
  }

  function age() public view returns(uint64) {
    return uint64(block.timestamp) - lastReset();
  }

  function lastReset() public view returns(uint64) {
    return resets[resets.length - 1];
  }

  function _resetIfNeeded() internal {
    if (!dueForReset()) return;
    _reset();
  }

  function _reset() internal {
    resets.push(uint64(block.timestamp));
    emit Reset();
  }

  function _hasTopScore(uint64 reset, address addr) internal view returns(bool) {
    for (uint256 i=0; i<topScores[reset].length; i++) {
      if (topScores[reset][i] == addr) {
        return true;
      }
    }
    return false;
  }

  function _insertionSort(uint64 reset) internal {
    uint length = topScores[reset].length;
    for (uint i = 1; i < length; i++) {
      address addr = topScores[reset][i];
      uint scoreKey = allScores[reset][addr];
      int j = int256(i - 1);
      while ((j >= 0) && allScores[reset][topScores[reset][uint256(j)]] < scoreKey) {
        topScores[reset][uint256(j + 1)] = topScores[reset][uint256(j)];
        j--;
      }
      topScores[reset][uint256(j + 1)] = addr;
    }
  }

  function _getTopScore(uint64 reset, uint256 index) internal view returns(uint256) {
    return allScores[reset][topScores[reset][index]];
  }

  modifier onlyFurballs() {
    require(msg.sender == _admin ||
      msg.sender == address(furballs));
      // || msg.sender == address(furballs.leaderboards()));
    _;
  }
}
