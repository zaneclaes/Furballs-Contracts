// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "hardhat/console.sol";
import "./Stakeholders.sol";

/// @title Referrers
/// @author LFG Gaming LLC
/// @notice In-game referral system for rewards
abstract contract Referrers is Stakeholders {
  // List of those who are referrers
  address[] public referrers;

  mapping(uint256 => address) public referrerIdToAddress;

  mapping(address => uint32) public referralCount;

  function getReferralCount(uint256 referrerId) public view returns(uint32) {
    return referralCount[referrerIdToAddress[referrerId]];
  }

  function getReferrerId(address addr) public view returns (uint256) {
    for (uint256 i=0; i<referrers.length; i++) {
      if (referrers[i] == addr) {
        return i + 1;
      }
    }
    return 0;
  }

  function becomeReferrer() public returns (uint256) {
    return _createReferrerId(msg.sender);
  }

  function _refer(uint256 referrerId, address referredAddress) internal returns(address) {
    address referringAddress = referrerIdToAddress[referrerId];
    if (referringAddress == address(0) || referringAddress == referredAddress) return address(0);
    referralCount[referringAddress]++;
    return referringAddress;
  }

  function _createReferrerId(address addr) internal returns(uint256) {
    uint256 rid = getReferrerId(addr);
    if (rid > 0) return rid;
    referrers.push(addr);
    rid = referrers.length;
    referrerIdToAddress[rid] = addr;
    return rid;
  }
}
