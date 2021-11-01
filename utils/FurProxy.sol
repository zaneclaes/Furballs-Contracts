// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../Furballs.sol";

/// @title FurProxy
/// @author LFG Gaming LLC
/// @notice Manages a link from a sub-contract back to the master Furballs contract
/// @dev Provides permissions by means of proxy
abstract contract FurProxy {
  Furballs public furballs;

  constructor(address furballsAddress) {
    furballs = Furballs(furballsAddress);
  }

  modifier onlyOwner() {
    require(furballs.owner() == msg.sender, "OWN");
    _;
  }

  modifier onlyAdmin() {
    require(furballs.isAdmin(msg.sender), "ADMIN");
    _;
  }

  modifier onlyModerators() {
    require(furballs.isModerator(msg.sender), 'MOD');
    _;
  }

  modifier onlyGame() {
    require(
      msg.sender == address(furballs) ||
      msg.sender == address(furballs.engine()) ||
      msg.sender == address(furballs.furgreement()) ||
      msg.sender == address(furballs.governance()) ||
      furballs.isAdmin(msg.sender), "GAME");
    _;
  }
}
