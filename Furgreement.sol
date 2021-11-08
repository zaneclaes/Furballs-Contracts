// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./Furballs.sol";
import "./Fur.sol";
import "./utils/FurProxy.sol";
// import "./IPlayRound.sol";
import "./l2/L2Lib.sol";
import "./l2/Bank.sol";
import "./zones/IZone.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @title Furgreement
/// @author LFG Gaming LLC
/// @notice Has permissions to act as a proxy to the Furballs contract
contract Furgreement is EIP712, FurProxy {
  // Tracker of wallet balances
  Bank public bank;

  // Map the zone number to the index in the zones array + 1
  mapping(uint32 => IZone) public zones;

  // List of zones in above mapping
  uint[] public zoneNumbers;

  constructor(
    address furballsAddress, address bankAddress
  ) EIP712("Furgreement", "1") FurProxy(furballsAddress) {
    bank = Bank(bankAddress);
  }

  /// @notice Public accessor to get a required zone
  function getZone(uint32 zoneNum) internal returns(IZone) {
    return _getZone(zoneNum);
  }

  /// @notice Lets game/admin change the cost to enter the pool
  function setZone(address zoneAddr) external gameAdmin {
    IZone zone = IZone(zoneAddr);
    uint32 zoneNum = uint32(zone.getZoneNumber());
    address existing = address(zones[zoneNum]);

    if (existing == address(0)) {
      zoneNumbers.push(zoneNum);
    }
    zones[zoneNum] = zone;
  }

  /// @notice Enters the pool zone with several furballs
  function poolEnter(uint256[] calldata tokenIds, uint32 poolZone) external payable {
    // Load the zone
    IZone zone = _getZone(poolZone);

    // Collect fees & check entrance
    if (msg.value > 0) bank.deposit(msg.sender, msg.value);
    require(bank.balance(msg.sender) >= zone.getCost(), 'COST');

    // Exit the prior zone and enter the pool
    furballs.playMany(tokenIds, poolZone, msg.sender);
  }

  /// @notice Direct payout from a pool, triggered by admins
  /// @dev Calculated off-chain
  function poolPayoutFur(
    address[] calldata recipients,
    uint256[] calldata furAmounts,
    uint256 cost
  ) external gameAdmin {
    for (uint i=0; i<recipients.length; i++) {
      uint withdrawn = bank.withdraw(recipients[i], cost);
      if (withdrawn >= (cost / 2)) {
        furballs.fur().earn(recipients[i], furAmounts[i]);
      }
    }
  }

  /// @notice Allows players to top-up balance
  /// @dev Pass zero address to apply to self
  function deposit(address to) external payable {
    require(msg.value > 0, 'VALUE');
    bank.deposit(to == address(0) ? msg.sender : to, msg.value);
  }

  /// @notice Sends payout to the treasury
  function withdraw() external gameAdmin {
    uint256 balance = address(this).balance;
    furballs.governance().treasury().transfer(balance);
  }

  /// @notice Helper to load a required zone
  function _getZone(uint32 zoneNum) internal returns(IZone) {
    IZone zone = zones[zoneNum];
    require(address(zone) != address(0), 'ZONE');
    return zone;
  }
}
