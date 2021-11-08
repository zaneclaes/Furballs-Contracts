// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "../utils/FurProxy.sol";

/// @title Bank
/// @author LFG Gaming LLC
/// @notice Simple tracker for how much ETH a user has deposited into Furballs' pools, etc.
contract Bank is FurProxy {
  mapping(address => uint256) public balance;

  constructor(address furballsAddress) FurProxy(furballsAddress) { }

  /// @notice Increases balance
  function deposit(address to, uint256 amount) external gameAdmin {
    balance[to] += amount;
  }

  /// @notice Decreases balance. Returns the amount withdrawn, where zero indicates failure.
  /// @dev Does not require/throw, but empties the balance when it exceeds the requested amount.
  function withdraw(address from, uint256 amount) external gameAdmin returns(uint) {
    uint256 bal = balance[from];
    if (bal == 0) {
      return 0;
    } else if (bal > amount) {
      balance[from] = bal - amount;
    } else {
      amount = bal;
      balance[from] = 0;
    }
    return amount;
  }
}
