// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Furballs.sol";
import "./editions/IFurballEdition.sol";

/// @title Fur
/// @author LFG Gaming LLC
/// @notice Utility token for in-game rewards in Furballs
contract Fur is ERC20 {
  Furballs public furballs;

  // n.b., this contract has some unusual tight-coupling between FUR and Furballs
  // Simple reason: this contract had more space, and is the only other allowed to know about ownership
  // Thus it serves as a sort of shop meta-store for Furballs

  // Counter of zero-loot-drops.
  mapping(address => uint32) public badLuck;

  // tokenId => mapping of fed _snacks
  mapping(uint256 => FurLib.Snack[]) public _snacks;

  constructor(address furballsAddress) ERC20("Fur", "FUR") {
    furballs = Furballs(payable(furballsAddress));
    _mint(msg.sender, 40000);
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

  /// @notice Returns the snacks currently applied to a Furball
  function snacks(uint256 tokenId) external view returns(FurLib.Snack[] memory) {
    return _snacks[tokenId];
  }

  /// @notice Write-function to cleanup the snacks for a token (remove expired)
  function cleanSnacks(uint256 tokenId) public {
    _cleanSnack(tokenId, 0);
  }

  /// @notice The public accessor calculates the snack boosts
  function modifyReward(
    uint256 tokenId, FurLib.RewardModifiers memory modifiers
  ) external view returns(FurLib.RewardModifiers memory) {
    // Add to base luck percent stat with the bad luck of the owner
    address owner = furballs.ownerOf(tokenId);
    modifiers.luckPercent += badLuck[owner];

    for (uint32 i=0; i<_snacks[tokenId].length && i <= FurLib.Max32; i++) {
      uint256 remaining = _snackTimeRemaning(_snacks[tokenId][i]);
      if (remaining > 0) {
        modifiers.happinessPoints += _snacks[tokenId][i].happiness;
        modifiers.energyPoints += _snacks[tokenId][i].energy;
      }
    }

    return modifiers;
  }

  /// @notice Updates "badLuck" stat, which creates loot drop boosts over time
  /// @dev Delegated logic from Furballs; returns input luck state for clean if/elses
  function handleLuck(bool goodLuck, address to) external onlyGame returns (bool) {
    return _handleLuck(goodLuck, to);
  }

  /// @notice Pay any necessary fees to mint a furball
  /// @dev Delegated logic from Furballs;
  function purchaseMint(
    address from, address to, IFurballEdition edition, uint8 count
  ) external onlyGame returns (bool) {
    require(edition.maxMintable(to) > 0, "LIVE");
    uint32 cnt = edition.count();

    require(count == 1 || furballs.isAdmin(from) || from == address(furballs.engine()), 'COUNT');
    uint32 adoptable = edition.maxAdoptable();
    bool requiresPurchase = cnt >= adoptable;

    if (requiresPurchase) {
      // _gift will throw if cannot gift or cannot afford cost
      _gift(from, to, edition.purchaseFur() * count);
    }
    return requiresPurchase;
  }

  /// @notice Attempts to purchase an upgrade for a loot item
  /// @dev Delegated logic from Furballs
  function purchaseUpgrade(
    address from, uint256 tokenId, uint128 lootId, FurLib.RewardModifiers memory modifiers
  ) external onlyGame returns(uint128) {
    address owner = furballs.ownerOf(tokenId);

    // _gift will throw if cannot gift or cannot afford cost
    _gift(from, owner, 1000);

    uint128 upgrade = furballs.engine().upgradeLoot(owner, lootId, modifiers);
    _handleLuck(upgrade != 0, owner);

    return upgrade;
  }

  /// @notice Attempts to purchase a snack using templates found in the engine
  /// @dev Delegated logic from Furballs
  function purchaseSnack(
    address from, uint256 tokenId, uint32 snackId, uint16 count
  ) external onlyGame {
    FurLib.Snack memory snack = furballs.engine().getSnack(snackId);
    require(snack.count > 0, 'COUNT');
    require(snack.fed == 0, 'FED');

    // _gift will throw if cannot gift or cannot afford costQ
    _gift(from, furballs.ownerOf(tokenId), snack.furCost * count);

    uint256 existingSnackNumber = _cleanSnack(tokenId, snack.snackId);
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
  function _cleanSnack(uint256 tokenId, uint32 snackId) internal returns(uint256) {
    uint256 ret = 0;
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
      if (snackId != 0 && _snacks[tokenId][i-1].snackId == snackId) {
        ret = i;
      }
    }
    return (ret);
  }

  /// @notice Check if the snack is active; returns 0 if inactive, otherwise the duration
  function _snackTimeRemaning(FurLib.Snack memory snack) internal view returns(uint256) {
    if (snack.fed == 0) return 0;
    uint256 expiresAt = uint256(snack.fed + (snack.count * snack.duration));
    return expiresAt <= block.timestamp ? 0 : (expiresAt - block.timestamp);
  }

  /// @notice Enforces (requires) only admins/game may give gifts
  /// @param to Whom is this being sent to?
  /// @return If this is a gift or not.
  function _gift(address from, address to, uint256 furCost) internal returns(bool) {
    bool isGift = to != from;

    // Only admins or game engine can send gifts (to != self), which are always free.
    require(!isGift || address(furballs.engine()) == from || furballs.isAdmin(from), 'GIFT');

    if (!isGift && furCost > 0) {
      _burn(from, furCost);
    }

    return isGift;
  }

  /// @notice Internal implementation of luck
  function _handleLuck(bool goodLuck, address to) internal returns (bool) {
    if (goodLuck) {
      badLuck[to] = 0;
    } else if(badLuck[to] < FurLib.OneHundredPercent) {
      // Bad luck caps out at 100% max
      badLuck[to] += uint32(5 * FurLib.OnePercent);
    }
    return goodLuck;
  }

  modifier onlyGame() {
    require(msg.sender == address(furballs) ||
      furballs.isAdmin(msg.sender) ||
      msg.sender == address(furballs.engine()), 'GAME');
    _;
  }
}
