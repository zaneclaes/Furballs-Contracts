// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./ILootEngine.sol";
import "../editions/IFurballEdition.sol";
import "../Furballs.sol";
import "../utils/FurLib.sol";
import "../utils/ProxyRegistry.sol";
import "../utils/Dice.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/// @title LootEngine
/// @author LFG Gaming LLC
/// @notice Base implementation of the loot engine
abstract contract LootEngine is ERC165, ILootEngine, Dice {
  Furballs public furballs;

  ProxyRegistry private _proxies;

  constructor(address furballsAddress, address proxyRegistry) {
    furballs = Furballs(furballsAddress);
    _proxies = ProxyRegistry(proxyRegistry);
  }

  /// @notice Hardcoded description for OpenSea
  function description() external virtual override pure returns (string memory) {
    return string(abi.encodePacked(
      "Furballs is a collectible NFT game, entirely on-chain. ",
      "There are 76 billion+ possible furball combinations, plus infinite loot and surprises."
    ));
  }

  /// @notice maxExperience is simply hardcoded for now.
  function maxExperience() external virtual override pure returns(uint32) {
    return 2010000;
  }

  /// @notice Checking the zone may use _require to detect preconditions.
  function enterZone(
    uint256 tokenId, uint32 zone, uint256[] memory team
  ) external virtual override returns(uint256) {
    // Nothing to see here.
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
  function upgradeLoot(
    address owner,
    uint128 lootId,
    FurLib.RewardModifiers memory modifiers
  ) external virtual override returns(uint128) {
    uint8 rarity = itemRarity(lootId);
    uint8 stat = itemStat(lootId);

    require(rarity > 0 && rarity < 3, 'RARITY');
    uint32 threshold = FurLib.Max32 / 1000 * (1000 - (rarity == 1 ? 75 : 25));
    uint256 rolled = (uint256(roll(0)) * uint256(modifiers.luckPercent)) / 100;

    if (rolled <= threshold) return 0;
    return (stat * 256) + uint16(rarity + 1) * (256 ** 2);
  }

  /// @notice Main loot-drop functionm
  function dropLoot(
    uint32 intervals,
    FurLib.RewardModifiers memory modifiers
  ) external virtual override onlyFurballs returns(uint128) {
    // Only battles drop loot.
    if (FurLib.isBattleZone(modifiers.zone)) return 0;
    if (modifiers.weight >= 50) return 0;

    (uint8 rarity, uint8 stat) = rollRarity(
      uint32((intervals * uint256(modifiers.luckPercent)) / 100), 0);
    if (rarity == 0) return 0;
    return (uint16(rarity) * (256 ** 2)) + (stat * 256);
  }

  /// @notice Core loot drop rarity randomization
  function rollRarity(uint32 chance, uint32 seed) public returns(uint8, uint8) {
    uint32 threshold = 4320;
    uint32 rolled = roll(seed) % threshold;
    uint8 stat = uint8(rolled % 2);

    if (chance > threshold || rolled >= (threshold - chance)) return (3, stat);
    threshold -= chance;
    if (chance * 2 > threshold || rolled >= (threshold - chance * 2)) return (2, stat);
    threshold -= chance * 2;
    if (chance * 4 > threshold || rolled >= (threshold - chance * 4)) return (1, stat);
    return (0, stat);
  }

  /// @notice The snack shop has IDs for each snack definition
  function getSnack(uint32 snackId) external view virtual override returns(FurLib.Snack memory) {
    FurLib.Snack memory snack = FurLib.Snack(snackId, 0, 0, 0, 0, 1, 0);
    if (snackId % 256 == 0) {
      uint8 snackSize = uint8((snackId / 256) % 256);
      if (snackSize == 1) {
        snack.duration = 8 * 360;
        snack.happiness = 15;
        snack.furCost = 100;
      } else if (snackSize == 2) {
        snack.duration = 24 * 360;
        snack.happiness = 20;
        snack.furCost = 300;
      } else if (snackSize == 3) {
        snack.duration = 72 * 360;
        snack.happiness = 25;
        snack.furCost = 900;
      }
    }
    return snack;
  }

  function modifyReward(
    uint256[] memory inventory,
    FurLib.RewardModifiers memory modifiers,
    uint32 teamSize,
    uint64 lastTradedAt,
    uint64 accountCreatedAt
  ) external virtual override view returns(FurLib.RewardModifiers memory) {
    // Raw/base stats
    modifiers.furPercent += uint32(modifiers.level * 2);

    // First add in the inventory
    for (uint256 i=0; i<modifiers.weight; i++) {
      uint128 lootId = uint128(inventory[i] / 256);
      uint32 stackSize = uint32(inventory[i] % 256);
      uint32 boost = uint32(itemRarity(lootId) * stackSize * 5);
      if (itemStat(lootId) == 0) {
        modifiers.expPercent += boost;
      } else {
        modifiers.furPercent += boost;
      }
    }

    // Reward players for holding, but also punish the whales...
    if (teamSize < 10 && teamSize > 1) {
      uint32 amt = uint32(2 * (teamSize - 1));
      modifiers.expPercent += amt;
      modifiers.furPercent += amt;
    } else if (teamSize > 10) {
      uint32 amt = uint32(5 * (teamSize > 20 ? 10 : (teamSize - 10)));
      modifiers.expPercent -= amt;
      modifiers.furPercent -= amt;
    }

    return modifiers;
  }

  function renderAttributes(
    uint256 tokenId
  ) external virtual override view returns(bytes memory) {
    FurLib.FurballStats memory stats = furballs.stats(tokenId, false);
    return abi.encodePacked(
      FurLib.traitValue("Level", stats.modifiers.level),
      FurLib.traitNumber("Edition", (tokenId % 256) + 1),
      FurLib.traitValue("Loot", stats.modifiers.weight),
      FurLib.traitValue("Rarity", stats.definition.rarity),
      FurLib.traitValue("EXP Rate", stats.expRate),
      FurLib.traitValue("FUR Rate", stats.furRate),
      FurLib.traitBoost("EXP", stats.modifiers.expPercent),
      FurLib.traitBoost("FUR", stats.modifiers.furPercent)
    );
  }

  /// @notice Converts a multiplier percentage (120%) into an "increase percent" (20%)
  function _boostPercent(uint32 percent) internal pure returns(uint256) {
    return percent > 100 ? (percent - 100) : 0;
  }

  // function _renderBoostAttribute(string memory trait, uint256 points) internal pure returns (bytes memory) {
  //   return abi.encodePacked('{"display_type": "boost_percentage", "trait_type": "',
  //     trait, '", "value": ', FurLib.uint2str(((points > 100) ? (points - 100) : 0)), '},');
  // }

  function itemRarity(uint128 lootId) public pure returns(uint8) {
    return FurLib.extractByte(lootId, 2);
  }

  function itemStat(uint128 lootId) public pure returns(uint8) {
    return FurLib.extractByte(lootId, 1);
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
