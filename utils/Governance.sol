// SPDX-License-Identifier: BSD-3-Clause
/// @title Vote checkpointing for an ERC-721 token
/*********************************
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░██░░░████░░██░░░████░░░ *
 * ░░██████░░░████████░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░██░░██░░░████░░██░░░████░░░ *
 * ░░░░░░█████████░░█████████░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 * ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ *
 *********************************/
// LICENSE
// Governance.sol uses and modifies part of Compound Lab's Comp.sol:
// https://github.com/compound-finance/compound-protocol/blob/ae4388e780a8d596d97619d9704a931a2752c2bc/contracts/Governance/Comp.sol
//
// Comp.sol source code Copyright 2020 Compound Labs, Inc. licensed under the BSD-3-Clause license.
// With modifications by Nounders DAO.
//
// Additional conditions of BSD-3-Clause can be found here: https://opensource.org/licenses/BSD-3-Clause
//
// MODIFICATIONS
// Checkpointing logic from Comp.sol has been used with the following modifications:
// - `delegates` is renamed to `_delegates` and is set to private
// - `delegates` is a public function that uses the `_delegates` mapping look-up, but unlike
//   Comp.sol, returns the delegator's own address if there is no delegate.
//   This avoids the delegator needing to "delegate to self" with an additional transaction
// - `_transferTokens()` is renamed `_beforeTokenTransfer()` and adapted to hook into OpenZeppelin's ERC721 hooks.
pragma solidity ^0.8.6;

import "./Stakeholders.sol";

contract Governance is Stakeholders {
  /// @notice Where transaction fees are deposited
  address payable public treasury;

  /// @notice How much is the transaction fee, in basis points?
  uint16 public transactionFee;

  /// @notice Defines decimals as per ERC-20 convention to make integrations with 3rd party governance platforms easier
  uint8 public constant decimals = 0;

  /// @notice A record of each accounts delegate
  mapping(address => address) private _delegates;

  /// @notice A checkpoint for marking number of votes from a given block
  struct Checkpoint {
    uint32 fromBlock;
    uint96 votes;
  }

  /// @notice A record of votes checkpoints for each account, by index
  mapping(address => mapping(uint32 => Checkpoint)) public checkpoints;

  /// @notice The number of checkpoints for each account
  mapping(address => uint32) public numCheckpoints;

  /// @notice The EIP-712 typehash for the contract's domain
  bytes32 public constant DOMAIN_TYPEHASH =
    keccak256('EIP712Domain(string name,uint256 chainId,address verifyingContract)');

  /// @notice The EIP-712 typehash for the delegation struct used by the contract
  bytes32 public constant DELEGATION_TYPEHASH =
    keccak256('Delegation(address delegatee,uint256 nonce,uint256 expiry)');

  /// @notice A record of states for signing / validating signatures
  mapping(address => uint256) public nonces;

  /// @notice An event thats emitted when an account changes its delegate
  event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);

  /// @notice An event thats emitted when a delegate account's vote balance changes
  event DelegateVotesChanged(address indexed delegate, uint256 previousBalance, uint256 newBalance);

  constructor(address furballsAddress) Stakeholders(furballsAddress) {
    treasury = payable(this);
  }

  function setTreasury(address payable treasuryAddress) external {
    require(furballs.isAdmin(msg.sender), 'ADMIN');
    treasury = treasuryAddress;
  }

  /**
   * @notice The votes a delegator can delegate, which is the current balance of the delegator.
   * @dev Used when calling `_delegate()`
   */
  function votesToDelegate(address delegator) public view returns (uint96) {
    return safe96(furballs.balanceOf(delegator), 'Governance::votesToDelegate: amount exceeds 96 bits');
  }
  /**
   * @notice Overrides the standard `Comp.sol` delegates mapping to return
   * the delegator's own address if they haven't delegated.
   * This avoids having to delegate to oneself.
   */
  function delegates(address delegator) public view returns (address) {
    address current = _delegates[delegator];
    return current == address(0) ? delegator : current;
  }

  /// @notice When a Furball levels up, voting shares are changed.
  function levelUp(address owner, uint16 oldLevel, uint16 newLevel) external {
    require(msg.sender == address(furballs), "Only Furballs can transfer delegates");
    _moveDelegates(delegates(owner), delegates(owner), uint96(oldLevel) + 1, uint96(newLevel) + 1);
  }

  /// @notice When a Furball is transferred, voting shares are adjusted for the old & new owner
  function transfer(address from, address to, uint16 level) external {
    require(msg.sender == address(furballs), "Only Furballs can transfer delegates");
    uint96 amount = uint96(level) + 1;
    _moveDelegates(delegates(from), delegates(to), amount, amount);
  }

  /**
   * @notice Delegate votes from `msg.sender` to `delegatee`
   * @param delegatee The address to delegate votes to
   */
  function delegate(address delegatee) public {
    if (delegatee == address(0)) delegatee = msg.sender;
    return _delegate(msg.sender, delegatee);
  }

  /**
   * @notice Delegates votes from signatory to `delegatee`
   * @param delegatee The address to delegate votes to
   * @param nonce The contract state required to match the signature
   * @param expiry The time at which to expire the signature
   * @param v The recovery byte of the signature
   * @param r Half of the ECDSA signature pair
   * @param s Half of the ECDSA signature pair
   */
  function delegateBySig(
    address delegatee,
    uint256 nonce,
    uint256 expiry,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) public {
    bytes32 domainSeparator = keccak256(
      abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(furballs.name())), getChainId(), address(this))
    );
    bytes32 structHash = keccak256(abi.encode(DELEGATION_TYPEHASH, delegatee, nonce, expiry));
    bytes32 digest = keccak256(abi.encodePacked('\x19\x01', domainSeparator, structHash));
    address signatory = ecrecover(digest, v, r, s);
    require(signatory != address(0), 'Governance::delegateBySig: invalid signature');
    require(nonce == nonces[signatory]++, 'Governance::delegateBySig: invalid nonce');
    require(block.timestamp <= expiry, 'Governance::delegateBySig: signature expired');
    return _delegate(signatory, delegatee);
  }

  /**
   * @notice Gets the current votes balance for `account`
   * @param account The address to get votes balance
   * @return The number of current votes for `account`
   */
  function getCurrentVotes(address account) external view returns (uint96) {
    uint32 nCheckpoints = numCheckpoints[account];
    return nCheckpoints > 0 ? checkpoints[account][nCheckpoints - 1].votes : 0;
  }

  /**
   * @notice Determine the prior number of votes for an account as of a block number
   * @dev Block number must be a finalized block or else this function will revert to prevent misinformation.
   * @param account The address of the account to check
   * @param blockNumber The block number to get the vote balance at
   * @return The number of votes the account had as of the given block
   */
  function getPriorVotes(address account, uint256 blockNumber) public view returns (uint96) {
    require(blockNumber < block.number, 'Governance::getPriorVotes: not yet determined');
    uint32 nCheckpoints = numCheckpoints[account];
    if (nCheckpoints == 0) {
      return 0;
    }
    // First check most recent balance
    if (checkpoints[account][nCheckpoints - 1].fromBlock <= blockNumber) {
      return checkpoints[account][nCheckpoints - 1].votes;
    }
    // Next check implicit zero balance
    if (checkpoints[account][0].fromBlock > blockNumber) {
      return 0;
    }
    uint32 lower = 0;
    uint32 upper = nCheckpoints - 1;
    while (upper > lower) {
      uint32 center = upper - (upper - lower) / 2; // ceil, avoiding overflow
      Checkpoint memory cp = checkpoints[account][center];
      if (cp.fromBlock == blockNumber) {
        return cp.votes;
      } else if (cp.fromBlock < blockNumber) {
        lower = center;
      } else {
        upper = center - 1;
      }
    }
    return checkpoints[account][lower].votes;
  }

  function _delegate(address delegator, address delegatee) internal {
    /// @notice differs from `_delegate()` in `Comp.sol` to use `delegates` override method to simulate auto-delegation
    address currentDelegate = delegates(delegator);
    _delegates[delegator] = delegatee;
    emit DelegateChanged(delegator, currentDelegate, delegatee);
    uint96 amount = votesToDelegate(delegator);
    _moveDelegates(currentDelegate, delegatee, amount, amount);
  }

  function _moveDelegates(
    address srcRep,
    address dstRep,
    uint96 amountFrom,
    uint96 amountTo
  ) internal {
    if (srcRep != address(0)) {
      uint32 srcRepNum = numCheckpoints[srcRep];
      uint96 srcRepOld = srcRepNum > 0 ? checkpoints[srcRep][srcRepNum - 1].votes : 0;
      uint96 srcRepNew = sub96(srcRepOld, amountFrom, 'Governance::_moveDelegates: amount underflows');
      _writeCheckpoint(srcRep, srcRepNum, srcRepOld, srcRepNew);
    }
    if (dstRep != address(0)) {
      uint32 dstRepNum = numCheckpoints[dstRep];
      uint96 dstRepOld = dstRepNum > 0 ? checkpoints[dstRep][dstRepNum - 1].votes : 0;
      uint96 dstRepNew = add96(dstRepOld, amountTo, 'Governance::_moveDelegates: amount overflows');
      _writeCheckpoint(dstRep, dstRepNum, dstRepOld, dstRepNew);
    }
  }

  function _writeCheckpoint(
    address delegatee,
    uint32 nCheckpoints,
    uint96 oldVotes,
    uint96 newVotes
  ) internal {
    uint32 blockNumber = safe32(
      block.number,
      'Governance::_writeCheckpoint: block number exceeds 32 bits'
    );
    if (nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber) {
      checkpoints[delegatee][nCheckpoints - 1].votes = newVotes;
    } else {
      checkpoints[delegatee][nCheckpoints] = Checkpoint(blockNumber, newVotes);
      numCheckpoints[delegatee] = nCheckpoints + 1;
    }
    emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
  }

  function safe32(uint256 n, string memory errorMessage) internal pure returns (uint32) {
    require(n < 2**32, errorMessage);
    return uint32(n);
  }

  function safe96(uint256 n, string memory errorMessage) internal pure returns (uint96) {
    require(n < 2**96, errorMessage);
    return uint96(n);
  }

  function add96(
    uint96 a,
    uint96 b,
    string memory errorMessage
  ) internal pure returns (uint96) {
    uint96 c = a + b;
    require(c >= a, errorMessage);
    return c;
  }

  function sub96(
    uint96 a,
    uint96 b,
    string memory errorMessage
  ) internal pure returns (uint96) {
    require(b <= a, errorMessage);
    return a - b;
  }

  function getChainId() internal view returns (uint256) {
    uint256 chainId;
    assembly {
      chainId := chainid()
    }
    return chainId;
  }
}