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
  constructor(
    address furballsAddress
  ) EIP712("FurOAuth", "1") FurProxy(furballsAddress) { }

  /// @notice Authentication just checks a valid token; returns error codes
  function authenticate(L2Lib.OAuthToken calldata token) external view returns(uint) {
    return _authenticate(token);
  }

  /// @notice Authorization uses require statements and returns an account with permissions
  function authorize(
    L2Lib.OAuthToken calldata token
  ) external view returns(FurLib.Account memory) {
    uint errorCode = _authenticate(token);

    require(errorCode != 1, "authorize: invalid signature");
    require(errorCode != 2, "ECDSA: invalid signature");
    require(errorCode != 3, "authorize: signed token expired");

    return furballs.governance().getAccount(token.owner);
  }

  /// @notice Internal authentication function, returns error codes
  function _authenticate(L2Lib.OAuthToken calldata token) internal view returns(uint) {
    bytes32 digest = _hashTypedDataV4(keccak256(abi.encode(
      keccak256("OAuthToken(address owner,uint32 access,uint64 deadline)"),
      token.owner,
      token.access,
      token.deadline
    )));

    address signer = ECDSA.recover(digest, token.signature);
    if (signer != token.owner) return 1;
    if (signer == address(0)) return 2;
    if (token.deadline != 0 && block.timestamp >= token.deadline) return 3;

    return 0;
  }
}
