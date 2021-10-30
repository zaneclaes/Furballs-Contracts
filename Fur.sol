// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Furballs.sol";
import "./editions/IFurballEdition.sol";

/// @title Fur
/// @author LFG Gaming LLC
/// @notice Utility token for in-game rewards in Furballs
contract Fur is ERC20 {
  // n.b., this contract has some unusual tight-coupling between FUR and Furballs
  // Simple reason: this contract had more space, and is the only other allowed to know about ownership
  // Thus it serves as a sort of shop meta-store for Furballs
  Furballs public furballs;

  string public metaName = "Furballs";

  string public metaDescription =
    "Furballs are entirely on-chain, with a full interactive gameplay experience at Furballs.com. "
    "There are 88 billion+ possible furball combinations in the first edition, each with their own special abilities"
    "... but only thousands minted per edition. Each edition has new artwork, game modes, and surprises.";

  // tokenId => mapping of fed _snacks
  mapping(uint256 => FurLib.Snack[]) public _snacks;

  // Tracks the MAX which are ever owned by a given address.
  mapping(address => uint256) public owned;

  // List of all addresses which have ever owned a furball.
  address[] public owners;

  constructor(address furballsAddress, uint256 startingBalance) ERC20("Fur", "FUR") {
    furballs = Furballs(furballsAddress);
    _mint(msg.sender, startingBalance);
  }

  /// @notice Update metadata for main contractURI
  function setMeta(string memory nameVal, string memory descVal) external onlyAdmin {
    metaName = nameVal;
    metaDescription = descVal;
  }

  /// @notice FUR can only be minted by furballs doing battle.
  function earn(address addr, uint256 amount) external onlyGame {
    if (amount == 0) return;
    _mint(addr, amount);
  }

  /// @notice FUR can be spent by Furballs, or by the LootEngine (shopping, in the future)
  function spend(address addr, uint256 amount) external onlyGame {
    _burn(addr, amount);
  }

  /// @notice Track the Furball ownership counts
  function updateOwnership(address addr, uint256 count) external onlyGame {
    uint256 exist = owned[addr];
    if (count <= exist) return;
    if (exist == 0) owners.push(addr);
    owned[addr] = count;
  }

  /// @notice Returns the snacks currently applied to a Furball
  function snacks(uint256 tokenId) external view returns(FurLib.Snack[] memory) {
    return _snacks[tokenId];
  }

  /// @notice Write-function to cleanup the snacks for a token (remove expired)
  function cleanSnacks(uint256 tokenId) public returns (uint16, uint16) {
    (uint256 existingSnackNumber, uint16 hap, uint16 en) = _cleanSnack(tokenId, 0);
    return (hap, en);
  }

  /// @notice The public accessor calculates the snack boosts
  function snackEffects(uint256 tokenId) external view returns(uint16, uint16) {
    // Add to base luck percent stat with the bad luck of the owner
    address owner = furballs.ownerOf(tokenId);
    uint16 hap = 0;
    uint16 en = 0;

    for (uint32 i=0; i<_snacks[tokenId].length && i <= FurLib.Max32; i++) {
      uint256 remaining = _snackTimeRemaning(_snacks[tokenId][i]);
      if (remaining > 0) {
        hap += _snacks[tokenId][i].happiness;
        en += _snacks[tokenId][i].energy;
      }
    }

    return (hap, en);
  }

  /// @notice Pay any necessary fees to mint a furball
  /// @dev Delegated logic from Furballs;
  function purchaseMint(
    address from, address to, IFurballEdition edition
  ) external onlyGame returns (bool) {
    require(edition.maxMintable(to) > 0, "LIVE");
    uint32 cnt = edition.count();

    uint32 adoptable = edition.maxAdoptable();
    bool requiresPurchase = cnt >= adoptable;

    if (requiresPurchase) {
      // _gift will throw if cannot gift or cannot afford cost
      _gift(from, to, edition.purchaseFur());
    }
    return requiresPurchase;
  }

  /// @notice Attempts to purchase an upgrade for a loot item
  /// @dev Delegated logic from Furballs
  function purchaseUpgrade(
    FurLib.RewardModifiers memory modifiers,
    address from, uint256 tokenId, uint128 lootId, uint8 chances
  ) external onlyGame returns(uint128) {
    address owner = furballs.ownerOf(tokenId);
    require(chances < 10 && chances > 0, "CHANCE");

    // _gift will throw if cannot gift or cannot afford cost
    _gift(from, owner, 500 * uint256(chances));

    return furballs.engine().upgradeLoot(modifiers, owner, lootId, chances);
  }

  /// @notice Attempts to purchase a snack using templates found in the engine
  /// @dev Delegated logic from Furballs
  function purchaseSnack(
    address from, uint256 tokenId, uint32 snackId, uint16 count
  ) external onlyGame {
    FurLib.Snack memory snack = furballs.engine().getSnack(snackId);
    require(snack.count > 0, "COUNT");
    require(snack.fed == 0, "FED");

    // _gift will throw if cannot gift or cannot afford costQ
    _gift(from, furballs.ownerOf(tokenId), snack.furCost * count);

    (uint256 existingSnackNumber, uint16 hap, uint16 en) = _cleanSnack(tokenId, snack.snackId);
    snack.count *= count;
    if (existingSnackNumber > 0) {
      // Adding count effectively adds duration to the active snack
      _snacks[tokenId][existingSnackNumber - 1].count += snack.count;
    } else {
      // A new snack just gets pushed onto the array
      snack.fed = uint64(block.timestamp);
      _snacks[tokenId].push(snack);
    }
  }

  /// @notice Both removes inactive _snacks from a token and searches for a specific snack Id index
  /// @dev Both at once saves some size & ensures that the _snacks are frequently cleaned.
  /// @return The index+1 of the existing snack
  function _cleanSnack(uint256 tokenId, uint32 snackId) internal returns(uint256, uint16, uint16) {
    uint256 ret = 0;
    uint16 hap = 0;
    uint16 en = 0;
    for (uint32 i=1; i<=_snacks[tokenId].length && i <= FurLib.Max32; i++) {
      FurLib.Snack memory snack = _snacks[tokenId][i-1];
      // Has the snack transitioned from active to inactive?
      if (_snackTimeRemaning(snack) == 0) {
        if (_snacks[tokenId].length > 1) {
          _snacks[tokenId][i-1] = _snacks[tokenId][_snacks[tokenId].length - 1];
        }
        _snacks[tokenId].pop();
        i--; // Repeat this idx
        continue;
      }
      hap += snack.happiness;
      en += snack.energy;
      if (snackId != 0 && snack.snackId == snackId) {
        ret = i;
      }
    }
    return (ret, hap, en);
  }

  /// @notice Check if the snack is active; returns 0 if inactive, otherwise the duration
  function _snackTimeRemaning(FurLib.Snack memory snack) internal view returns(uint256) {
    if (snack.fed == 0) return 0;
    uint256 interval = furballs.intervalDuration();
    uint256 expiresAt = uint256(snack.fed + (snack.count * snack.duration * interval));
    return expiresAt <= block.timestamp ? 0 : (expiresAt - block.timestamp);
  }

  /// @notice Enforces (requires) only admins/game may give gifts
  /// @param to Whom is this being sent to?
  /// @return If this is a gift or not.
  function _gift(address from, address to, uint256 furCost) internal returns(bool) {
    bool isGift = to != from;

    // Only admins or game engine can send gifts (to != self), which are always free.
    require(!isGift || address(furballs.engine()) == from || furballs.isAdmin(from), "GIFT");

    if (!isGift && furCost > 0) {
      _burn(from, furCost);
    }

    return isGift;
  }

  modifier onlyAdmin() {
    require(furballs.isAdmin(msg.sender), "ADMIN");
    _;
  }

  modifier onlyGame() {
    require(msg.sender == address(furballs) ||
      msg.sender == address(furballs.engine()) ||
      msg.sender == address(furballs.furgreement()) ||
      furballs.isAdmin(msg.sender), "GAME");
    _;
  }
}
