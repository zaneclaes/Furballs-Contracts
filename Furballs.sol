// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./editions/IFurballEdition.sol";
import "./engines/ILootEngine.sol";
import "./engines/EngineA.sol";
import "./utils/FurLib.sol";
import "./utils/Stakeholders.sol";
import "./utils/Governance.sol";
import "./Fur.sol";

/// @title Furballs
/// @author LFG Gaming LLC
/// @notice Mints Furballs on the Ethereum blockchain
/// @dev https://furballs.com/contract
contract Furballs is ERC721Enumerable, Stakeholders {
  Fur public fur;

  IFurballEdition[] editions;

  ILootEngine public engine;

  Governance public governance;

  // tokenId => furball data
  mapping(uint256 => FurLib.Furball) public furballs;

  // The amount of time over which FUR/EXP is accrued (usually 360=>1hour)
  uint256 private _interval;

  event Spawn(uint256 tokenId, address addr, uint8 editionIndex, uint32 editionCount);
  event Play(uint256 tokenId, uint256 furBalance, FurLib.FurballStats);
  event Pickup(uint256 tokenId, uint32 slot, uint256 loot, FurLib.FurballStats);
  event Drop(uint256 tokenId, uint32 slot, uint256 loot);
  event Upgrade(uint256 tokenId, uint32 slot, uint256 old, uint256 upgrade);

  constructor(uint256 interval) ERC721("Furballs", "FBL") {
    _interval = interval;
  }

  function inventory(uint256 tokenId) external view returns(uint256[] memory) {
    require(_exists(tokenId));
    return furballs[tokenId].inventory;
  }

  // -----------------------------------------------------------------------------------------------
  // Public transactions
  // -----------------------------------------------------------------------------------------------

  /// @notice Mints a new furball from the current edition (if there are any remaining)
  /// @dev Limits and fees are set by IFurballEdition
  function mint(address to, uint8 editionIndex, uint8 count) external {
    require(editionIndex < editions.length, "ED");

    // Will _require necessary conditions
    fur.purchaseMint(_approvedSender(), to, editions[editionIndex], count);

    for (uint8 i=0; i<count; i++) {
      _spawn(to, editionIndex, 0);
    }
  }

  /// @notice Feeds the furball a snack
  /// @dev Delegates logic to fur
  function feed(uint256 tokenId, uint32 snackId) external {
    fur.purchaseSnack(_approvedSender(), tokenId, engine.getSnack(snackId));
  }

  /// @notice Begins exploration mode with the given furballs
  /// @dev Multiple furballs accepted at once to reduce gas fees
  /// @param tokenIds The furballs which should start exploring
  /// @param zone The explore zone (otherwize, zero for battle mode)
  function play(uint256[] memory tokenIds, uint32 zone) external {
    zone = uint32(engine.enterZone(tokenIds, zone));
    address sender = _approvedSender();

    for (uint256 i=0; i<tokenIds.length; i++) {
      // The engine is allowed to force furballs into exploration mode
      // This allows it to end a battle early, which will be necessary in PvP
      require(ownerOf(tokenIds[i]) == sender || address(engine) == sender, 'OWN');
      _collect(tokenIds[i]);
      furballs[tokenIds[i]].zone = zone;
      emit Play(
        tokenIds[i],
        fur.balanceOf(ownerOf(tokenIds[i])),
        stats(tokenIds[i]));
    }
  }

  /// @notice Re-dropping loot allows players to pay $FUR to re-roll an inventory slot
  /// @param tokenId The furball in question
  /// @param slot The slot in its inventory to re-roll
  function upgrade(uint256 tokenId, uint32 slot) external {
    // Attempt upgrade (random chance).
    uint256 upgrade = fur.purchaseUpgrade(_approvedSender(), tokenId, slot);
    if (upgrade != 0) {
      furballs[tokenId].inventory[slot] = upgrade;
    }

    // Emit upgrade, regardless of if successful, for client
    emit Upgrade(tokenId, slot, furballs[tokenId].inventory[slot], upgrade);
  }

  /// @notice The LootEngine can directly send loot to a furball!
  /// @dev This allows for gameplay expansion, i.e., new game modes
  /// @param tokenId The furball
  /// @param loot The loot ID being sent
  function pickup(uint256 tokenId, uint256 loot) external {
    require(msg.sender == address(engine) || isAdmin(msg.sender), 'ENG');
    require(_exists(tokenId));
    uint32 slot = uint32(furballs[tokenId].inventory.length);
    furballs[tokenId].inventory.push(loot);
    emit Pickup(tokenId, slot, loot, stats(tokenId));
  }

  /// @notice The LootEngine can cause a furball to drop loot!
  /// @dev This allows for gameplay expansion, i.e., new game modes
  /// @param tokenId The furball
  /// @param slot The slot being dropped
  function drop(uint256 tokenId, uint32 slot) external {
    require(msg.sender == address(engine) || isAdmin(msg.sender), 'ENG');
    require(_exists(tokenId));
    uint256 len = furballs[tokenId].inventory.length;
    require(slot < len, 'SLOT');
    uint256 loot = furballs[tokenId].inventory[slot];
    if (len > 1) {
      furballs[tokenId].inventory[slot] = furballs[tokenId].inventory[len - 1];
    }
    furballs[tokenId].inventory.pop();
    emit Drop(tokenId, slot, loot);
  }

  // -----------------------------------------------------------------------------------------------
  // Internal
  // -----------------------------------------------------------------------------------------------

  /// @notice Calculates full reward modifier stack for a furball in a zone.
  function _rewardModifiers(
    uint256 tokenId, uint32 zone, uint32 teamSize
  ) internal view returns(FurLib.RewardModifiers memory) {
    return engine.getRewardModifiers(
      fur.getRewardModifiers(
        tokenId,
        editions[tokenId % 256].getRewardModifiers(
          tokenId,
          expToLevel(furballs[tokenId].experience),
          zone
        )
      ),
      teamSize,
      furballs[tokenId].inventory
    );
  }

  /// @notice Ends the current explore/battle and dispenses rewards
  /// @param tokenId The furball
  function _collect(uint256 tokenId) internal {
    address owner = ownerOf(tokenId);
    uint64 duration = uint64(block.timestamp) - furballs[tokenId].last;
    require(duration > 0);

    FurLib.RewardModifiers memory mods =
      _rewardModifiers(tokenId, furballs[tokenId].zone, uint32(balanceOf(owner)));

    if (!FurLib.isBattleZone(mods.zone)) { // Explore!
      uint32 exp = _expFromExplore(tokenId, duration, mods);
      uint32 has = furballs[tokenId].experience;
      if (exp > 0 && has < (FurLib.Max32 - exp)) {
        uint8 oldLevel = expToLevel(has);

        has += exp;
        furballs[tokenId].experience = has;

        uint8 newLevel = expToLevel(has);
        if (newLevel > oldLevel) {
          governance.transferDelegates(owner, owner, oldLevel + 1, newLevel + 1);
        }
      }
    } else { // Battle!
      // Each edition earns less fur (the divisor):
      uint256 f = _furFromBattle(tokenId, duration, mods);
      if (f > 0) {
        fur.earn(owner, f);
      }
    }

    // uint64 owned = uint64(block.timestamp) - furballs[tokenId].trade;
    uint256 loot = engine.dropLoot(uint32(duration / uint64(_interval)), mods);
    if (fur.handleLuck(loot > 0, owner)) {
      uint32 slot = uint32(furballs[tokenId].inventory.length);
      furballs[tokenId].inventory.push(loot);
      emit Pickup(tokenId, slot, loot, stats(tokenId));
    }

    // Clean the snacks as part of the transaction for good housekeeping
    fur.cleanSnacks(tokenId);

    furballs[tokenId].last = uint64(block.timestamp);
  }

  /// @notice Mints a new furball
  /// @dev Recursive function; generates randomization seed for the edition
  /// @param to The recipient of the furball
  /// @param nonce A recursive counter to prevent infinite loops
  function _spawn(address to, uint8 editionIndex, uint8 nonce) internal {
    require(nonce < 10, "SUPPLY");
    require(editionIndex < editions.length, "ED");

    // Generate a random furball tokenId; if it fails to be unique, recurse!
    uint256 tokenId = editions[editionIndex].spawn() + editionIndex;
    if (_exists(tokenId)) return _spawn(to, editionIndex, nonce + 1);

    // Ensure that this wallet has not exceeded its per-edition mint-cap
    uint32 owned = editions[editionIndex].minted(to);
    uint32 limit = editions[editionIndex].maxMintable(to);
    require(owned < limit, "LIMIT");

    // Check the current edition's constraints (caller should have checked costs)
    uint32 cnt = editions[editionIndex].count();
    uint32 max = editions[editionIndex].maxCount();
    require(cnt < max, "MAX");

    // Create the memory struct that represens the furball
    uint256 furballNumber = totalSupply() + 1;
    uint64 ts = uint64(block.timestamp);
    uint256[] memory inventory;
    furballs[tokenId] = FurLib.Furball(furballNumber, cnt, 0, 0, ts, ts, ts, inventory);

    // Finally, mint the token and increment internal counters
    _mint(to, tokenId);

    editions[editionIndex].addCount(to, 1);
    emit Spawn(tokenId, to, editionIndex, cnt + 1);
  }

  /// @notice Happens each time a furball changes wallets
  /// @dev Keeps track of the furball timestamp
  function _beforeTokenTransfer(
      address from,
      address to,
      uint256 tokenId
  ) internal override {
    super._beforeTokenTransfer(from, to, tokenId);
    furballs[tokenId].trade = uint64(block.timestamp);
    engine.onTrade(from, to, tokenId);

    uint8 governanceAmount = expToLevel(furballs[tokenId].experience) + 1;
    governance.transferDelegates(from, to, governanceAmount, governanceAmount);
  }

  // -----------------------------------------------------------------------------------------------
  // Game Engine & Moderation
  // -----------------------------------------------------------------------------------------------

  function stats(uint256 tokenId) public view returns(FurLib.FurballStats memory) {
    // Base stats are calculated from the zero (null) zone (exploring green pastures?)
    FurLib.RewardModifiers memory mods = _rewardModifiers(tokenId, 0, 0);

    return FurLib.FurballStats(
      _expFromExplore(tokenId, _interval, mods),
      _furFromBattle(tokenId, _interval, mods),
      mods,
      furballs[tokenId]
    );
  }

  function expToLevel(uint32 exp) public pure returns(uint8) {
    if (exp >= 2010000) return 200; // Max level

    uint x = exp / 100;
    if (x < 1) return 0;

    // Calculate sqrt
    x += (x - 1);
    if (x <= 2) return 1;
    else if (x <= 3) return 2;

    uint z = (x + 1) / 2;
    uint y = x;
    while (z < y) {
      y = z;
      z = (x / z + z) / 2;
    }
    return uint8(y);
    // uint32 expRequired = 0;
    // exp /= 100;
    // for (uint8 level = 1; level <= 200; level++) {
    //   expRequired += uint32(level);
    //   if (exp < expRequired) {
    //     return level - 1;
    //   }
    // }
    // return 200;
  }

  function _expFromExplore(
    uint256 tokenId, uint256 duration, FurLib.RewardModifiers memory mods
  ) internal view returns(uint32) {
    return uint32(_calculateReward(
      duration,
      500, // Base happiness is always const per interval
      (uint256(mods.expPercent) + uint256(mods.happinessPoints * FurLib.OnePercent))
    ));
  }

  function _furFromBattle(
    uint256 tokenId, uint256 duration, FurLib.RewardModifiers memory mods
  ) internal view returns(uint32) {
    uint32 editionIndex = uint32(tokenId % 256);
    return uint32(_calculateReward(
      duration,
      editionIndex <= 4 ? (10 - editionIndex * 2) : 2, // Each edition ears less fur per interval
      (uint256(mods.furPercent))
    ));
  }

  function _calculateReward(
    uint256 duration, uint256 perInterval, uint256 percentBoost
  ) internal view returns(uint256) {
    return (duration * percentBoost * perInterval) / (FurLib.OneHundredPercent * _interval);
  }

  // -----------------------------------------------------------------------------------------------
  // Public Views/Accessors (for outside world)
  // -----------------------------------------------------------------------------------------------

  /// @notice Provides the OpenSea storefront
  /// @dev see https://docs.opensea.io/docs/contract-level-metadata
  function contractURI() public view returns (string memory) {
    return string(abi.encodePacked("data:application/json;base64,", FurLib.encode(abi.encodePacked(
      '{"name": "Furballs", "description": "A game built entirely on the blockchain"',
      ', "external_link": "https://furballs.com"',
      ', "seller_fee_basis_points": 250, "fee_recipient": "',
      FurLib.bytesHex(abi.encodePacked(address(this))), '"}'
    ))));
  }

  /// @notice Provides the on-chain Furball asset
  /// @dev see https://docs.opensea.io/docs/metadata-standards
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId));
    uint8 editionIndex = uint8(tokenId % 256);
    return string(abi.encodePacked("data:application/json;base64,", FurLib.encode(abi.encodePacked(
      editions[editionIndex].tokenData(
        tokenId,
        furballs[tokenId].number,
        furballs[tokenId].birth,
        engine.renderAttributes(editionIndex, stats(tokenId))
      )
    ))));
  }

  // -----------------------------------------------------------------------------------------------
  // OpenSea Proxy
  // -----------------------------------------------------------------------------------------------

  /// @notice Whitelisting the proxy registies for secondary market transactions
  /// @dev See OpenSea ERC721Tradable
  function isApprovedForAll(address owner, address operator)
      override
      public
      view
      returns (bool)
  {
    return engine.canProxyTrades(owner, operator) || super.isApprovedForAll(owner, operator);
  }

  /// @notice This is used instead of msg.sender as transactions won't be sent by the original token owner, but by OpenSea.
  /// @dev See OpenSea ContentMixin
  function _msgSender()
    internal
    override
    view
    returns (address sender)
  {
    if (msg.sender == address(this)) {
      bytes memory array = msg.data;
      uint256 index = msg.data.length;
      assembly {
        // Load the 32 bytes word from memory with the address on the lower 20 bytes, and mask those.
        sender := and(
          mload(add(array, index)),
          0xffffffffffffffffffffffffffffffffffffffff
        )
      }
    } else {
      sender = msg.sender;
    }
    return sender;
  }

  // -----------------------------------------------------------------------------------------------
  // Configuration / Admin
  // -----------------------------------------------------------------------------------------------

  function init(address furAddress, address engineAddress, address gov, address edition) external onlyAdmin {
    require(!_isReady(), 'RDY');
    fur = Fur(furAddress);
    governance = Governance(gov);

    setEngine(engineAddress);
    addEdition(edition, 0);
  }

  function setEngine(address addr) public onlyAdmin {
    engine = ILootEngine(addr);
  }

  function addEdition(address addr, uint8 idx) public onlyAdmin {
    require(addr != address(0));
    IFurballEdition edition = IFurballEdition(addr);
    require(edition.supportsInterface(type(IFurballEdition).interfaceId));
    if (idx >= editions.length) {
      editions.push(edition);
    } else {
      editions[idx] = edition;
    }
  }

  function _isReady() internal view returns(bool) {
    return address(engine) != address(0) && editions.length > 0
      && address(fur) != address(0) && address(governance) != address(0);
  }

  /// @notice Handles auth of msg.sender against cheating and/or banning.
  function _approvedSender() internal view returns (address) {
    require(_isReady(), '!RDY');
    return engine.approveSender(_msgSender());
  }

  // -----------------------------------------------------------------------------------------------
  // Payable
  // -----------------------------------------------------------------------------------------------

  /// @notice This contract can be paid transaction fees, e.g., from OpenSea
  /// @dev The contractURI specifies itself as the recipient of transaction fees
  receive() external payable { }
}
