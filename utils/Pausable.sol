// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Moderated.sol";

/// @title Pausable
/// @author LFG Gaming LLC
/// @notice Pausing gameplay
abstract contract Pausable is Moderated {
  bool public paused = false;

  event Pause();
  event Unpause();

  modifier whenNotPaused() {
    require(paused == false);
    _;
  }

  modifier whenPaused() {
    require(paused == true);
    _;
  }

  modifier whenReady() {
    require(paused == false && isReady() == true);
    _;
  }

  modifier whenNotReady() {
    require(paused == true || isReady() == false);
    _;
  }

  function isReady() public virtual returns(bool) {
    return true;
  }

  function pause() external whenNotPaused onlyModerators returns (bool) {
    paused = true;
    emit Pause();
    return true;
  }

  function unpause() external whenPaused onlyModerators returns (bool) {
    paused = false;
    emit Unpause();
    return true;
  }
}
