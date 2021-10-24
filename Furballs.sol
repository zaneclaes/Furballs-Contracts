// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./editions/IFurballEdition.sol";
import "./engines/ILootEngine.sol";
import "./engines/EngineA.sol";
import "./utils/FurLib.sol";
import "./utils/FurDefs.sol";
import "./utils/Stakeholders.sol";
import "./utils/Governance.sol";
import "./utils/Exp.sol";
import "./Fur.sol";
// import "hardhat/console.sol";

/// @title Furballs
/// @author LFG Gaming LLC
/// @notice Mints Furballs on the Ethereum blockchain
/// @dev https://furballs.com/contract
contract Furballs is ERC721Enumerable, Stakeholders, Exp {
  Fur public fur;

  IFurballEdition[] public editions;

  ILootEngine public engine;

  Governance public governance;

  // tokenId => furball data
  mapping(uint256 => FurLib.Furball) public furballs;

  // tokenId => item type => slot number for that item
  mapping(uint256 => mapping(uint128 => uint32)) public inventories;

  // tokenId => all rewards assigned to that Furball
  mapping(uint256 => FurLib.Rewards[]) public collect;

  // When did this address get its first furball?
  mapping(address => uint64) public age;

  // The amount of time over which FUR/EXP is accrued (usually 360=>1hour)
  uint256 private _interval;

  event Spawn(uint256 tokenId, address addr, uint8 editionIndex, uint32 editionCount);
  event Play(uint256 tokenId, uint256 responseId);
  event Pickup(uint256 tokenId, uint32 slot, uint128 lootId);
  event Drop(uint256 tokenId, uint32 slot, uint128 lootId, uint32 count);

  constructor(uint256 interval) ERC721("Furballs", "FBL") {
    _interval = interval;
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
  function feed(uint256 tokenId, uint32 snackId, uint16 count) external {
    fur.purchaseSnack(_approvedSender(), tokenId, snackId, count);
  }

  /// @notice Begins battle/explore modes by changing zones & collecting rewards
  /// @dev See also: playMany, _play
  function playOne(uint256 tokenId, uint32 zone) external {
    uint256[] memory team;
    _play(tokenId, zone, _approvedSender(), team);
  }

  /// @notice Begins exploration mode with the given furballs
  /// @dev Multiple furballs accepted at once to reduce gas fees
  /// @param tokenIds The furballs which should start exploring
  /// @param zone The explore zone (otherwize, zero for battle mode)
  function playMany(uint256[] memory tokenIds, uint32 zone) external {
    address sender = _approvedSender();

    for (uint256 i=0; i<tokenIds.length; i++) {
      _play(tokenIds[i], zone, sender, tokenIds);
    }
  }

  /// @notice Re-dropping loot allows players to pay $FUR to re-roll an inventory slot
  /// @param tokenId The furball in question
  /// @param lootId The lootId in its inventory to re-roll
  function upgrade(uint256 tokenId, uint128 lootId) external {
    // Attempt upgrade (random chance).
    uint128 up = fur.purchaseUpgrade(
      _approvedSender(), tokenId, lootId, _rewardModifiers(tokenId, address(0)));
    if (up != 0) {
      _drop(tokenId, lootId, 1);
      _pickup(tokenId, up);
    }
  }

  /// @notice The LootEngine can directly send loot to a furball!
  /// @dev This allows for gameplay expansion, i.e., new game modes
  /// @param tokenIds The furball to gain the loot
  /// @param lootId The loot ID being sent
  function pickup(uint256[] memory tokenIds, uint128 lootId) external onlyGame {
    require(lootId > 0, 'LOOT');
    for (uint256 i=0; i<tokenIds.length; i++) {
      _pickup(tokenIds[i], lootId);
    }
  }

  /// @notice LootEngine/battle reward tool for assigning loot on chance
  function loot(uint256[] memory tokenIds, uint32 chance) external onlyGame {
    for (uint256 i=0; i<tokenIds.length; i++) {
      uint256 tokenId = tokenIds[i];
      uint128 lootId = engine.dropLoot(chance, _rewardModifiers(tokenId, address(0)));
      if (lootId != 0) _pickup(tokenId, lootId);
    }
  }

  /// @notice The LootEngine can cause a furball to drop loot!
  /// @dev This allows for gameplay expansion, i.e., new game modes
  /// @param tokenId The furball
  /// @param lootId The item to drop
  /// @param count the number of that item to drop
  function drop(uint256 tokenId, uint128 lootId, uint32 count) external onlyGame {
    _drop(tokenId, lootId, count);
  }

  // -----------------------------------------------------------------------------------------------
  // Internal
  // -----------------------------------------------------------------------------------------------

  /// @notice Internal implementation of playMany/playOne
  function _play(uint256 tokenId, uint32 zone, address sender, uint256[] memory team) internal {
    address owner = ownerOf(tokenId);

    // The engine is allowed to force furballs into exploration mode
    // This allows it to end a battle early, which will be necessary in PvP
    require(owner == sender || address(engine) == sender, 'OWN');

    // Check zone preconditions
    zone = uint32(engine.enterZone(tokenId, zone, team));

    // Run reward collection
    _collect(tokenId);

    // Set new zone
    furballs[tokenId].zone = zone;
  }

  /// @notice Remove an inventory item from a furball
  function _drop(uint256 tokenId, uint128 lootId, uint32 count) internal {
    uint32 slot = inventories[tokenId][lootId];
    require(slot > 0 && slot <= uint32(furballs[tokenId].inventory.length), 'SLOT');

    slot -= 1;
    uint32 stackSize = uint32(furballs[tokenId].inventory[slot] % 256);

    if (count >= stackSize) {
      // Drop entire stack
      inventories[tokenId][lootId] = 0;
      uint32 len = uint32(furballs[tokenId].inventory.length);
      if (len > 1) {
        furballs[tokenId].inventory[slot] = furballs[tokenId].inventory[len - 1];
        inventories[tokenId][uint128(furballs[tokenId].inventory[slot] / 256)] = slot + 1;
      }
      furballs[tokenId].inventory.pop();
    } else {
      stackSize -= count;
      furballs[tokenId].inventory[slot] = uint256(lootId) * 256 + stackSize;
    }

    emit Drop(tokenId, slot, lootId, count);
  }

  /// @notice Internal implementation of adding a single known loot item to a Furball
  function _pickup(uint256 tokenId, uint128 lootId) internal {
    uint32 slotNum = inventories[tokenId][lootId];
    uint32 stackSize = 1;
    if (slotNum == 0) {
      furballs[tokenId].inventory.push(uint256(lootId) * 256 + stackSize);
      inventories[tokenId][lootId] = uint32(furballs[tokenId].inventory.length);
    } else {
      stackSize += uint32(furballs[tokenId].inventory[slotNum - 1] % 256);
      furballs[tokenId].inventory[slotNum - 1] = uint256(lootId) * 256 + stackSize;
    }
    emit Pickup(tokenId, stackSize, lootId);
  }

  /// @notice Calculates full reward modifier stack for a furball in a zone.
  function _rewardModifiers(
    uint256 tokenId, address ownerContext
  ) internal view returns(FurLib.RewardModifiers memory) {
    // uint32 rarity, uint32 teamSize, uint32 zone, uint64 accountCreatedAt
    bool context = ownerContext != address(0);

    // Create the base modifiers based upon current level, rarity, and zone.
    uint32 editionIndex = uint32(tokenId % 256);
    uint256 rarityBoost =  context ? (furballs[tokenId].rarity * FurLib.OnePercent) : 0;
    uint256 furDecrease = (editionIndex < 4 ? (editionIndex * 20) : 80) * FurLib.OnePercent;

    FurLib.RewardModifiers memory reward = FurLib.RewardModifiers(
      uint32(FurLib.OneHundredPercent + rarityBoost),
      uint32(FurLib.OneHundredPercent + rarityBoost - furDecrease),
      uint32(FurLib.OneHundredPercent),
      0, // Baseline zero happiness
      0, // Baseline zero energy
      context ? furballs[tokenId].zone : 0,
      uint16(furballs[tokenId].inventory.length),
      furballs[tokenId].level
    );

    // Allow the edition to modify the reward for special zone-based strengths
    reward = editions[editionIndex].modifyReward(tokenId, reward);

    // FUR will apply snacks and luck (happiness, energy, luck)
    reward = fur.modifyReward(tokenId, reward);

    // Engine will consider inventory and team size in zone
    reward = engine.modifyReward(
      furballs[tokenId].inventory,
      reward,
      uint32(context && !isAdmin(ownerContext) ? balanceOf(ownerContext) : 0),
      context ? age[ownerContext] : 0);

    // Add happiness/energy to core stats after everything else
    if (context) reward.expPercent += uint32(reward.happinessPoints * FurLib.OnePercent);

    return reward;
  }

  /// @notice Ends the current explore/battle and dispenses rewards
  /// @param tokenId The furball
  function _collect(uint256 tokenId) internal {
    address owner = ownerOf(tokenId);
    FurLib.Rewards memory res = FurLib.Rewards(
      uint64(block.timestamp) - furballs[tokenId].last, 0,0,0,0);

    FurLib.RewardModifiers memory mods = _rewardModifiers(tokenId, owner);

    if (!FurLib.isBattleZone(mods.zone)) { // Explore!
      res.experience = uint32(_calculateReward(res.duration, FurLib.EXP_PER_INTERVAL, mods.expPercent));
      uint32 has = furballs[tokenId].experience;
      uint32 max = engine.maxExperience();
      if (res.experience > 0) {
        has = (has < (max - res.experience)) ? (has + res.experience) : max;
        furballs[tokenId].experience = has;

        uint16 level = expToLevel(has, max);
        furballs[tokenId].level = level;

        if (level > mods.level) {
          res.levels = (level - mods.level);
          if (address(governance) != address(0)) governance.levelUp(owner, mods.level, level);
        }
      }
    } else { // Battle!
      // Each edition earns less fur (the divisor):
      res.fur = _calculateReward(res.duration, FurLib.FUR_PER_INTERVAL, mods.furPercent);
      if (res.fur > 0) {
        fur.earn(owner, res.fur);
      }
    }

    // Generate loot and assign to furball
    res.loot = engine.dropLoot(uint32(res.duration / uint64(_interval)), mods);
    if (fur.handleLuck(res.loot > 0, owner)) {
      _pickup(tokenId, res.loot);
    }

    // Clean the snacks as part of the transaction for good housekeeping
    fur.cleanSnacks(tokenId);

    // Stash this as the last play response
    collect[tokenId].push(res);

    // Emit the reward ID for frontend
    emit Play(tokenId, collect[tokenId].length);

    furballs[tokenId].last = uint64(block.timestamp);
  }

  /// @notice Mints a new furball
  /// @dev Recursive function; generates randomization seed for the edition
  /// @param to The recipient of the furball
  /// @param nonce A recursive counter to prevent infinite loops
  function _spawn(address to, uint8 editionIndex, uint8 nonce) internal {
    require(nonce < 10, "SUPPLY");
    require(editionIndex < editions.length, "ED");

    IFurballEdition edition = editions[editionIndex];

    // Generate a random furball tokenId; if it fails to be unique, recurse!
    (uint256 tokenId, uint32 rarity) = edition.spawn();
    tokenId += editionIndex;
    if (_exists(tokenId)) return _spawn(to, editionIndex, nonce + 1);

    // Ensure that this wallet has not exceeded its per-edition mint-cap
    uint32 owned = edition.minted(to);
    uint32 limit = edition.maxMintable(to);
    require(owned < limit, "LIMIT");

    // Check the current edition's constraints (caller should have checked costs)
    uint32 cnt = edition.count();
    uint32 max = edition.maxCount();
    require(cnt < max, "MAX");

    // Create the memory struct that represens the furball
    uint256[] memory inv;
    furballs[tokenId] = FurLib.Furball(
      totalSupply() + 1, cnt, rarity, 0, 0, 0,
      uint64(block.timestamp), uint64(block.timestamp), uint64(block.timestamp), inv);

    // Finally, mint the token and increment internal counters
    _mint(to, tokenId);

    edition.addCount(to, 1);
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

    if (age[to] == 0) age[to] = uint64(block.timestamp);
    if (address(governance) != address(0)) governance.transfer(from, to, furballs[tokenId].level);
  }

  // -----------------------------------------------------------------------------------------------
  // Game Engine & Moderation
  // -----------------------------------------------------------------------------------------------

  function stats(uint256 tokenId, bool contextual) public view returns(FurLib.FurballStats memory) {
    // Base stats are calculated without team size so this doesn't effect public metadata
    FurLib.RewardModifiers memory mods =
      _rewardModifiers(tokenId, contextual ? ownerOf(tokenId) : address(0));

    return FurLib.FurballStats(
      uint32(_calculateReward(_interval, FurLib.EXP_PER_INTERVAL, mods.expPercent)),
      uint32(_calculateReward(_interval, FurLib.FUR_PER_INTERVAL, mods.furPercent)),
      mods,
      furballs[tokenId],
      fur.snacks(tokenId)
    );
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
        furballs[tokenId].birth
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

  function setFur(address furAddress) external onlyAdmin {
    fur = Fur(furAddress);
  }

  function setGovernance(address addr) public onlyAdmin {
    governance = Governance(addr);
  }

  function setEngine(address addr) public onlyAdmin {
    engine = ILootEngine(addr);
  }

  function addEdition(address addr, uint8 idx) public onlyAdmin {
    if (idx >= editions.length) {
      editions.push(IFurballEdition(addr));
    } else {
      editions[idx] = IFurballEdition(addr);
    }
  }

  function _isReady() internal view returns(bool) {
    return address(engine) != address(0) && editions.length > 0 && address(fur) != address(0);
  }

  /// @notice Handles auth of msg.sender against cheating and/or banning.
  function _approvedSender() internal view returns (address) {
    require(_isReady(), '!RDY');
    return engine.approveSender(_msgSender());
  }

  modifier onlyGame() {
    require(msg.sender == address(engine) || isAdmin(msg.sender), 'ENG');
    _;
  }

  // -----------------------------------------------------------------------------------------------
  // Payable
  // -----------------------------------------------------------------------------------------------

  /// @notice This contract can be paid transaction fees, e.g., from OpenSea
  /// @dev The contractURI specifies itself as the recipient of transaction fees
  receive() external payable { }
}
