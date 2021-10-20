// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract OtherDice {
  uint32 NONCE = 0;

  function addNonce() public {
    NONCE++;
  }

  // The Anonymice randomization function, which tends to fail length-of-run tests.
  function randAnonymice(uint256 _t) public view returns (uint16) {
    uint256 _c = 0;
    return uint16(
        uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.difficulty,
                    _t,
                    msg.sender,
                    _c,
                    NONCE
                )
            )
        )
    );
  }

  bytes32 internal entropySauce;

  function addEntropy() public {
    entropySauce = keccak256(abi.encodePacked(msg.sender, block.coinbase));
  }

  function randEtherOrcs(uint256 i) public view returns (uint16) {
    uint256 rand = uint256(
      keccak256(abi.encodePacked(msg.sender, block.timestamp, block.basefee, block.timestamp, entropySauce))
    );
    return uint16(uint256(keccak256(abi.encode(rand, "HELM", i))));
  }
}
