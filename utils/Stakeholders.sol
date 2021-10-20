// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Moderated.sol";
import "./FurLib.sol";

/// @title Stakeholders
/// @author LFG Gaming LLC
/// @notice Tracks "percent ownership" of a smart contract, paying out according to schedule
abstract contract Stakeholders is Moderated {
  // stakeholder values, in 1/1000th of a percent (received during withdrawls)
  mapping(address => uint64) public stakes;

  // List of stakeholders
  address[] public stakeholders;

  constructor() {
    // Start with a single stakeholder, reserving 10% for referrals.
    // setStakeholder(msg.sender, 90000);
  }

  function getStakeholding(address addr) public view returns(uint64) {
    if (!_hasStakeholder(addr)) return 0;
    return stakes[addr];
  }

  function setStakeholder(address addr, uint64 stake) public onlyOwner {
    if (!_hasStakeholder(addr)) {
      stakeholders.push(addr);
    }
    uint64 percent = stake;
    for (uint256 i=0; i<stakeholders.length; i++) {
      if (stakeholders[i] != addr) {
        percent += stakes[stakeholders[i]];
      }
    }

    require(percent <= FurLib.OneHundredPercent, "Invalid stake (exceeds 100%)");
    stakes[addr] = stake;
  }

  function withdraw() external onlyModerators {
    uint256 balance = address(this).balance;
    require(balance >= FurLib.OneHundredPercent, "Insufficient balance");

    for (uint256 i=0; i<stakeholders.length; i++) {
      address addr = stakeholders[i];
      uint256 payout = balance * stakes[addr] / FurLib.OneHundredPercent;
      if (payout > 0) {
        payable(addr).transfer(payout);
      }
    }
    uint256 remaining = address(this).balance;
    payable(owner()).transfer(remaining);
  }

  function _hasStakeholder(address addr) internal view returns(bool) {
    for (uint256 i=0; i<stakeholders.length; i++) {
      if (stakeholders[i] == addr) {
        return true;
      }
    }
    return false;
  }
}
