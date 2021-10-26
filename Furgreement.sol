// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @title Furballs
/// @author LFG Gaming LLC
/// @notice Has permissions to act as a proxy to the Furballs contract
/// @dev https://soliditydeveloper.com/ecrecover
contract Furgreement is EIP712 {
  Furballs public furballs;

  mapping(address => uint256) private nonces;

  // A "move to be made" in the sig queue
  struct PlayMove {
    uint32 zone;
    uint256[] tokenIds;
  }

  constructor(address furballsAddress) EIP712("Furgreement", "1") {
    furballs = Furballs(furballsAddress);
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

    furballs.playMany(move.tokenIds, move.zone, owner);
  }
}

// interface Comp {
//   function delegateBySig(
//     address delegatee,
//     uint nonce,
//     uint expiry,
//     uint8 v,
//     bytes32 r,
//     bytes32 s
//   ) external;
// }

// contract FurDelegate {
//   struct Furgreement {

//     // address delegatee;
//     // uint nonce;
//     // uint expiry;
//     // uint8 v;
//     // bytes32 r;
//     // bytes32 s;
//   }

//   // function delegateBySigs(Furgreement[] memory sigs) public {
//   //   Comp comp = Comp(0xc00e94Cb662C3520282E6f5717214004A7f26888);

//   //   for (uint i = 0; i < sigs.length; i++) {
//   //     Furgreement memory sig = sigs[i];
//   //     comp.delegateBySig(sig.delegatee, sig.nonce, sig.expiry, sig.v, sig.r, sig.s);
//   //   }
//   // }
// }
