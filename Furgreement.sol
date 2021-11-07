// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "./utils/FurProxy.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @title Furballs
/// @author LFG Gaming LLC
/// @notice Has permissions to act as a proxy to the Furballs contract
/// @dev https://soliditydeveloper.com/ecrecover
contract Furgreement is EIP712, FurProxy {
  mapping(address => uint256) private nonces;

  address[] public addressQueue;

  mapping(address => PlayMove) public pendingMoves;

  mapping(uint256 => uint256) public zones;

  mapping(uint32 => uint256) public tokenQueue;

  uint256 token0;

  uint32 public tokenIdx;

  // A "move to be made" in the sig queue
  struct PlayMove {
    uint256[] tokenIds;
    uint32 zone;
  }

  struct TokenAction {
    uint32 zone;
    address sender;
  }

  mapping(uint256 => TokenAction) public actions;

  constructor(address furballsAddress) EIP712("Furgreement", "1") FurProxy(furballsAddress) { }

  function move(uint256 tokenId, uint32 zone) external {
    actions[tokenId].zone = zone;
    actions[tokenId].sender = msg.sender;
    // require(furballs.ownerOf(tokenId) == address(msg.sender), "OWNER");
    // tokenQueue.push(tokenId);
    // zones[tokenId] = zone + 1;
    // token0 = tokenId;
    // tokenQueue[tokenIdx] = tokenId;
    // tokenIdx = tokenIdx + 1;
  }

  function moves(uint256 idx) external returns(TokenAction memory ret) {
    if (idx == 1) return TokenAction(0, address(0));
    return ret;
  }

  function pushMove(uint256[] calldata tokenIds, uint32 zone) external {
    addressQueue.push(msg.sender);
    pendingMoves[msg.sender].tokenIds = tokenIds;
    pendingMoves[msg.sender].zone = zone;
  }

  function processMoves() external {
    uint len = addressQueue.length;
    uint tq = 0;
    while(tq < len) {
      // tq = tq - 1;
      address sender = addressQueue[tq];
      PlayMove memory move = pendingMoves[sender];
      furballs.playMany(move.tokenIds, move.zone, sender);
      tq = tq + 1;
      // addressQueue.pop();
    }
  }

  /// @notice Proxy playMany to Furballs contract
  function playFromSignature(
    bytes memory signature,
    address owner,
    PlayMove memory move,
    uint256 deadline
  ) external {
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
      keccak256("playMany(address owner,PlayMove memory move,uint256 nonce,uint256 deadline)"),
      owner,
      move,
      nonces[owner],
      deadline
    )));

    address signer = ECDSA.recover(digest, signature);
    require(signer == owner, "playMany: invalid signature");
    require(signer != address(0), "ECDSA: invalid signature");

    require(block.timestamp < deadline, "playMany: signed transaction expired");
    nonces[owner]++;

    if (pendingMoves[owner].tokenIds.length == 0) {
      addressQueue.push(owner);
    }
    pendingMoves[owner] = move;
  }
}
