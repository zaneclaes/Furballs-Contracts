// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "../Furballs.sol";
import "./FurLib.sol";

/// @title FurProxy
/// @author LFG Gaming LLC
/// @notice Manages a link from a sub-contract back to the master Furballs contract
/// @dev Provides permissions by means of proxy
abstract contract FurProxy {
  Furballs public furballs;

  constructor(address furballsAddress) {
    furballs = Furballs(furballsAddress);
  }

  modifier onlyOwner() {
    require(_permissions(msg.sender) >= FurLib.PERMISSION_OWNER, "OWN");
    _;
  }

  modifier onlyAdmin() {
    require(_permissions(msg.sender) >= FurLib.PERMISSION_ADMIN, "ADMIN");
    _;
  }

  modifier onlyModerators() {
    require(_permissions(msg.sender) >= FurLib.PERMISSION_MODERATOR, "MOD");
    _;
  }

  modifier onlyFurballs() {
    require(msg.sender == address(furballs), "FBL");
    _;
  }

  modifier onlyGame() {
    require(_permissions(msg.sender) >= FurLib.PERMISSION_ADMIN, "GAME");
    _;
  }

  /// @notice Generalized permissions flag for a given address
  function _permissions(address addr) internal view returns (uint8) {
    if (addr == address(0)) return 0;
    if (addr == address(furballs) ||
      addr == address(furballs.engine()) ||
      addr == address(furballs.furgreement()) ||
      addr == address(furballs.governance()) ||
      addr == address(furballs.fur())
    ) {
      return FurLib.PERMISSION_CONTRACT;
    }
    return _userPermissions(addr);
  }

  function _userPermissions(address addr) internal view returns (uint8) {
    if (addr == address(0)) return 0;
    if (addr == furballs.owner()) return FurLib.PERMISSION_OWNER;
    if (furballs.isAdmin(addr)) return FurLib.PERMISSION_ADMIN;
    if (furballs.isModerator(addr)) return FurLib.PERMISSION_MODERATOR;
    return 0;
  }
}
