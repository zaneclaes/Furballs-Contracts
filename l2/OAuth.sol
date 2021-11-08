// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../Furballs.sol";
import "./L2Lib.sol";
import "../utils/FurLib.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @title OAuthToken
/// @author LFG Gaming LLC
/// @notice Uses EIP712 to authorize a user for an L2 API client
contract OAuth is EIP712, FurProxy {
  // The payload of a token
  struct Token {
    address owner;
    uint32 access;
    uint64 deadline;
  }

  constructor(
    address furballsAddress
  ) EIP712("FurballsOAuthToken", "1") FurProxy(furballsAddress) { }

  /// @notice Authorize a token for the owner
  function authorize(
    bytes calldata signature,
    Token calldata token
  ) external view returns(FurLib.Account memory) {
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
      keccak256("Token(address owner,uint32 access,uint64 deadline)"),
      token.owner,
      token.access,
      token.deadline
    )));

    address signer = ECDSA.recover(digest, signature);
    require(signer == token.owner, "authorize: invalid signature");
    require(signer != address(0), "ECDSA: invalid signature");
    require(token.deadline == 0 || block.timestamp < token.deadline,
      "authorize: signed token expired");

    return furballs.governance().getAccount(token.owner);
  }
}
