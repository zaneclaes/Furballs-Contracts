// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "hardhat/console.sol";
import "./ILootEngine.sol";
import "../editions/IFurballEdition.sol";
import "../Furballs.sol";
import "../utils/Dice.sol";
import "../utils/FurLib.sol";
import "../utils/ProxyRegistry.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/// @title LootEngine
/// @author LFG Gaming LLC
/// @notice Base implementation of the loot engine
abstract contract LootEngine is ERC165, ILootEngine, Dice {
  Furballs public furballs;

  ProxyRegistry private _proxies;

  constructor(address furballsAddress, address proxyRegistry) {
    furballs = Furballs(payable(furballsAddress));
    _proxies = ProxyRegistry(proxyRegistry);
  }

  /// @notice Basic zoning check just ensures that there's at least one Furball.
  function enterZone(uint256[] memory tokenIds, uint32 zone) external virtual override returns(uint256) {
    require(tokenIds.length >= 1, 'TEAM');
    return uint256(zone);
  }

  /// @notice Proxy logic is presently delegated to OpenSea-like contract
  function canProxyTrades(address owner, address operator) external virtual override view onlyFurballs returns(bool) {
    if (address(_proxies) == address(0)) return false;
    return address(_proxies.proxies(owner)) == operator;
  }

  /// @notice Allow a player to play? Throws on error if not.
  /// @dev This is core gameplay security logic
  function approveSender(address sender) external virtual override view onlyFurballs returns(address) {
    // Engine itself is allowed to act as a player so it may adjust game state
    if (sender == address(this)) return sender;

    // Ensure the sender is a wallet, or that it is an approved proxy
    uint256 size;
    assembly { size := extcodesize(sender) }
    require(sender == tx.origin && size == 0, 'PLR');

    return sender;
  }

  /// @notice The trade hook does nothing right now.
  function onTrade(
    address from, address to, uint256 tokenId
  ) external virtual override onlyFurballs { }

  /// @notice Attempt to upgrade a given piece of loot (item ID)
  function upgradeLoot(uint256 item, uint32 badLuck) external virtual override returns(uint256) {
    uint8 rarity = itemRarity(item);
    uint8 stat = itemStat(item);

    require(rarity > 0 && rarity < 3, 'RARITY');
    uint32 threshold = FurLib.Max32 / 1000 * (1000 - (rarity == 1 ? 75 : 25));
    if (roll(0) <= threshold) return 0;
    return (stat * 256) + uint16(rarity + 1) * (256 ** 2);
  }

  /// @notice Main loot-drop function
  function dropLoot(
    uint32 intervals, FurLib.RewardModifiers memory mods
  ) external virtual override onlyFurballs returns(uint256) {
    // Only battles drop loot.
    if (FurLib.isBattleZone(mods.zone)) return 0;

    uint256 mult = uint256(mods.luckPercent);
    uint8 rarity = rollRarity(uint32(intervals * mult / FurLib.OneHundredPercent), 0);
    if (rarity == 0) return 0;
    uint8 stat = uint8(roll(0) % 2);
    return (stat * 256) + uint16(rarity) * (256 ** 2);
  }

  /// @notice Core loot drop rarity randomization
  function rollRarity(uint32 chance, uint32 seed) public returns(uint8) {
    uint32 threshold = 4320;
    uint32 rolled = roll(seed) % threshold;

    if (chance > threshold || rolled >= (threshold - chance)) return 3;
    threshold -= chance;
    if (chance * 2 > threshold || rolled >= (threshold - chance * 2)) return 2;
    threshold -= chance * 2;
    if (chance * 4 > threshold || rolled >= (threshold - chance * 4)) return 1;
    return 0;
  }

  /// @notice The snack shop has IDs for each snack definition
  function getSnack(uint32 snackId) external view virtual override returns(FurLib.Snack memory) {
    FurLib.Snack memory snack = FurLib.Snack(snackId, 0, 0, 0, 0, 1, 0);
    if (snackId % 256 == 0) {
      uint8 snackSize = uint8((snackId / 256) % 256);
      if (snackSize == 1) {
        snack.duration = 8 * 360;
        snack.happiness = 15;
        snack.furCost = 10;
      } else if (snackSize == 2) {
        snack.duration = 24 * 360;
        snack.happiness = 20;
        snack.furCost = 30;
      } else if (snackSize == 3) {
        snack.duration = 72 * 360;
        snack.happiness = 25;
        snack.furCost = 90;
      }
    }
    return snack;
  }

  function getRewardModifiers(
    FurLib.RewardModifiers memory modifiers,
    uint32 teamSize,
    uint256[] memory inventory
  ) external virtual override view returns(FurLib.RewardModifiers memory) {
    // Raw/base stats
    modifiers.furPercent += uint32(FurLib.OnePercent * modifiers.level * 2);

    // First add in the inventory
    for (uint256 i=0; i<inventory.length; i++) {
      uint32 boost = uint32(itemRarity(inventory[i]) * 5 * FurLib.OnePercent);
      if (itemStat(inventory[i]) == 0) {
        modifiers.expPercent += boost;
      } else {
        modifiers.furPercent += boost;
      }
    }

    // Reward players for holding, but also punish the whales...
    if (teamSize < 10 && teamSize > 1) {
      uint32 amt = uint32(2 * (teamSize - 1) * FurLib.OnePercent);
      modifiers.expPercent += amt;
      modifiers.furPercent += amt;
    } else if (teamSize > 10) {
      uint32 amt = uint32(5 * (teamSize > 20 ? 10 : (teamSize - 10)) * FurLib.OnePercent);
      modifiers.expPercent -= amt;
      modifiers.furPercent -= amt;
    }

    return modifiers;
  }

  function renderAttributes(
    uint8 editionIndex, FurLib.FurballStats memory stats
  ) external virtual override view returns(bytes memory) {
    return abi.encodePacked(
      FurLib.traitValue("Level", stats.modifiers.level),
      FurLib.traitNumber("Edition", 0, editionIndex + 1),
      FurLib.traitValue("EXP Rate", stats.expRate),
      FurLib.traitValue("FUR Rate", stats.furRate),
      FurLib.traitNumber("EXP Boost", 1, _clampBoost(stats.modifiers.expPercent)),
      FurLib.traitNumber("FUR Boost", 1, _clampBoost(stats.modifiers.furPercent))
    );
  }

  function _clampBoost(uint32 percent) internal pure returns(uint256) {
    return percent > FurLib.OneHundredPercent ? (percent / FurLib.OnePercent - 100) : 0;
  }

  // function _renderBoostAttribute(string memory trait, uint256 points) internal pure returns (bytes memory) {
  //   return abi.encodePacked('{"display_type": "boost_percentage", "trait_type": "',
  //     trait, '", "value": ', FurLib.uint2str(((points > 100) ? (points - 100) : 0)), '},');
  // }

  function itemRarity(uint256 item) public pure returns(uint8) {
    return FurLib.extractByte(item, 1);
  }

  function itemStat(uint256 item) public pure returns(uint8) {
    return FurLib.extractByte(item, 2);
  }

  function _expBoosterName(uint8 rarity) internal pure returns(string memory) {
    if (rarity == 1) return "Shoe";
    if (rarity == 2) return "Frisbee";
    if (rarity == 3) return "Laser Pointer";
    require(false, 'RARITY');
  }

  function _furBoosterName(uint8 rarity) internal pure returns(string memory) {
    if (rarity == 1) return "Fur-spray";
    if (rarity == 2) return "Fur-tilizer";
    if (rarity == 3) return "Fur-gaine";
    require(false, 'RARITY');
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
    return
      interfaceId == type(ILootEngine).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  modifier onlyFurballs() {
    require(msg.sender == address(furballs));
    _;
  }
}
