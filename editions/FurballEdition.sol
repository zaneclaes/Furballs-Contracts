// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./IFurballEdition.sol";
import "../Furballs.sol";
import "../utils/FurLib.sol";
import "../utils/FurDefs.sol";
import "../utils/Dice.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "./IFurballPart.sol";
import "./IFurballPaths.sol";
import "./IFurballPalette.sol";
// import "hardhat/console.sol";

/// @title FurballEdition
/// @author LFG Gaming LLC
/// @notice Base class for a furball edition with common implementations
abstract contract FurballEdition is ERC165, IFurballEdition, Dice {
  // Internal reference to the EditionIndex
  uint8 public override index = 0;

  // The time at which this edition goes live
  uint64 public override liveAt = 0;

  // How many exist in this edition?
  uint16 public override count = 0;

  // The names of the slots used by this edition
  string[] public slots;

  // How many has each wallet minted in this edition?
  mapping(address => uint16) public override minted;

  IFurballPart[] private _parts;

  IFurballPalette private _palette;

  mapping(address => uint256) internal _whitelist;

  mapping(uint256 => string) public names;

  // A new furball was added to this edition.
  event Spawn(uint8 editionIndex, uint32 editionCount);

  IFurballPaths[] private _paths;

  uint32[4] private rarities = [
    FurLib.Max32 / 1000 * 848, // 9%
    FurLib.Max32 / 1000 * 938, // 5%
    FurLib.Max32 / 1000 * 988, // 1%
    FurLib.Max32 / 1000 * 998  // 0.2%
  ];

  Furballs public furballs;

  uint8 private _numPalettes;

  uint8 private _numBackgrounds;

  address private _owner;

  mapping(uint8 => mapping(uint8 => uint8[])) private _options;

  function modifyReward(
    FurLib.RewardModifiers memory modifiers, uint256 tokenId
  ) external override virtual view returns(FurLib.RewardModifiers memory) {
    return modifiers;
  }

  constructor(
    address furballsAddress, address paletteAddress, address[] memory partsAddresses, address[] memory pathsAddresses
  ) {
    furballs = Furballs(furballsAddress);
    _palette = IFurballPalette(paletteAddress);
    _owner = msg.sender;

    _numPalettes = _palette.numPalettes();
    _numBackgrounds = _palette.numBackgroundColors();

    uint8 i=0;
    for (; i<partsAddresses.length; i++) {
      setPart(partsAddresses[i], i);
    }
    for (i=0; i<pathsAddresses.length; i++) {
      setPath(pathsAddresses[i], i);
    }
  }

  /// @notice Main "mint" function for the edition, generating the tokenID & rarity
  function spawn() external override returns (uint256, uint16) {
    uint8 palette = uint8(roll(0) % _numPalettes);
    uint8 bk = uint8(roll(0) % _numBackgrounds);
    uint256 numSlots = slots.length;
    uint256 tokenId = (bk * 0x10000) + (palette * 0x100);
    uint16 boost = 0;
    for (uint8 slot=0; slot<numSlots; slot++) {
      (uint256 id, uint8 rarity) = rollSlot(0, slot, 0);
      tokenId += id * FurLib.bytePower(slot + 3);
      if(rarity > 0) {
        if (rarity == 1) boost += 10;
        else if (rarity == 2) boost += 15;
        else if (rarity == 3) boost += 20;
        else if (rarity == 4) boost += 30;
      }
    }
    return (tokenId, boost);
  }

  // -----------------------------------------------------------------------------------------------
  // Admin
  // -----------------------------------------------------------------------------------------------

  /// @notice Allow upgrading contract links
  function setFurballs(address addr) external onlyAdmin {
    furballs = Furballs(addr);
  }

  function setPart(address addr, uint8 i) public onlyAdmin {
    IFurballPart part = IFurballPart(addr);
    string memory sn = part.slot();

    if (i >= _parts.length) {
      slots.push(sn);
      _parts.push(part);
    } else {
      slots[i] = sn;
      _parts[i] = part;
    }

    for (uint8 r=0; r<=3; r++) {
      _options[uint8(i)][uint8(r)] = part.options(r);
    }
  }

  function setPath(address addr, uint8 i) public onlyAdmin {
    IFurballPaths paths = IFurballPaths(addr);

    if (i >= _paths.length) {
      _paths.push(paths);
    } else {
      _paths[i] = paths;
    }
  }

  function addCount(address to, uint16 amount) external override returns(bool) {
    require(furballs.isAdmin(msg.sender) || msg.sender == address(furballs));
    count += amount;
    minted[to] += amount;
    emit Spawn(index, count);
    return true;
  }

  function setLiveAt(uint64 at) public onlyAdmin {
    liveAt = at;
  }

  function addToWhitelist(address[] calldata addresses, uint256 num) public onlyAdmin {
    unchecked {
      for (uint256 i=0; i<addresses.length; i++) {
        _whitelist[addresses[i]] = num;
      }
    }
  }

  // -----------------------------------------------------------------------------------------------
  // Metadata
  // -----------------------------------------------------------------------------------------------

  /// @notice Metadata loader
  function tokenMetadata(
    bytes memory attributes, uint256 tokenId, uint256 number
  ) external virtual override view returns(bytes memory) {
    return abi.encodePacked(
      '{"name": "', _nameOf(tokenId, number),
        // '", "external_url": "https://furballs.com/#/furball/', FurLib.bytesHex(abi.encodePacked(tokenId)),
        '", "background_color": "', _palette.backgroundColor(uint8(FurLib.extractBytes(tokenId, 2, 1))),
        '", "image": "data:image/svg+xml;base64,', FurLib.encode(_render(tokenId)),
        '", "description": "', furballs.engine().furballDescription(tokenId),
        '", "attributes": [', attributes, _getAttributes(tokenId),
      ']}'
    );
  }

  /// @notice Moderators or the game itself can customize a furball with names & descriptions
  function customize(uint256 tokenId, string memory fbName) external {
    require(
      furballs.isModerator(msg.sender) || // covers the admin & owner cases
      address(furballs.engine()) == msg.sender
    );
    names[tokenId] = fbName;
  }

  function _nameOf(uint256 tokenId, uint256 number) internal virtual view returns(string memory) {
    string memory fbName = names[tokenId];
    return string(abi.encodePacked(
      bytes(fbName).length > 0 ? fbName : "Furball", " #", FurLib.uint2str(number)));
  }


  function _getAttributes(uint256 tokenId) internal virtual view returns (string memory) {
    bytes memory ret = "";
    bool added = false;
    for (uint8 slot=0; slot<slots.length; slot++) {
      uint8 idx = uint8(FurLib.extractBytes(tokenId, slot + 3, 1));
      if (idx == 0) continue;
      idx--;

      ret = abi.encodePacked(ret,
        added ? ', ' : '',
        '{"trait_type": "', slots[slot], '", "value": "',
        _parts[slot].name(idx), FurDefs.raritySuffix(_getRarity(slot, idx)), '"}'
      );
      added = true;
    }
    return string(ret);
  }

  // -----------------------------------------------------------------------------------------------
  // Rarity / Rolls
  // -----------------------------------------------------------------------------------------------

  function rollRarity(uint32 seed) public returns(uint8) {
    uint32 rolled = roll(seed);
    for (uint8 r=4; r>0; r--) {
      if (rolled > rarities[r - 1]) {
        return r;
      }
    }
    return 0;
  }

  function rollSlot(uint32 seed, uint8 slot, uint8 rarity) public returns(uint256, uint8) {
    rarity = rarity > 0 ? rarity : rollRarity(seed);
    uint8[] memory opts = _options[slot][rarity];
    uint8 numOpts = uint8(opts.length);
    if (numOpts == 0) {
      if (rarity >= 1) {
        // Rolled a rare attribute, but there were no options. Re-try this roll.
        return rollSlot(seed, slot, rarity - 1);
      } else {
        // This is a null slot.
        return (0, 0);
      }
    }
    return (opts[roll(seed) % opts.length] + 1, rarity);
  }

  function _getRarity(uint8 slot, uint8 idx) internal virtual view returns(uint8) {
    for (uint8 rarity = 1; rarity <= 4; rarity++) {
      uint8[] memory opts = _options[slot][rarity];
      for (uint8 o=0; o<opts.length; o++) {
        if (opts[o] == idx) {
          return rarity;
        }
      }
    }
    return 0;
  }

  // -----------------------------------------------------------------------------------------------
  // SVG
  // -----------------------------------------------------------------------------------------------

  function _render(uint256 tokenId) internal virtual view returns (bytes memory) {
    uint8 palette = uint8(FurLib.extractBytes(tokenId, 1, 1));
    bytes memory ret = abi.encodePacked(
      '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 350" >',
      furballs.engine().render(tokenId)
    );
    for (uint8 slot=0; slot<slots.length; slot++) {
      uint8 idx = uint8(FurLib.extractBytes(tokenId, slot + 3, 1));
      if (idx == 0) continue;
      ret = abi.encodePacked(ret, renderSlot(slot, idx - 1, palette));
    }
    return abi.encodePacked(ret, '</svg>');
  }

  function renderSlot(uint8 slot, uint8 idx, uint8 palette) public view returns(string memory) {
    bytes memory svg = '';
    bytes memory tag;
    bytes memory data = _parts[slot].data();
    uint64 ptr = _pointer(data, idx, true) + 3;
    uint8 numTags = uint8(data[ptr - 1]);
    for (uint8 t=0; t < numTags; t++) {
      (ptr, tag) = _renderTag(ptr, data, palette);
      svg = abi.encodePacked(svg, tag);
    }
    return string(svg);
  }

  function _pointer(bytes memory data, uint8 idx, bool twoByte) internal pure returns(uint64) {
    if (idx == 0) return 0;
    uint64 ptr = 0;
    for (uint256 i=0; i<idx; i++) {
      uint16 length = uint16(uint8(data[ptr]));
      if (twoByte) {
        length = (length * 256) + uint16(uint8(data[ptr + 1]));
      }
      ptr += (twoByte ? 2 : 1) + length;
    }
    return ptr;
  }

  function _renderTag(uint64 ptr, bytes memory data, uint8 palette) internal view returns(uint64, bytes memory) {
    string[11] memory tagMap = [
      'g', 'circle', 'ellipse', 'line', 'linearGradient', 'radialGradient',
      'path', 'polygon', 'polyline', 'stop', 'rect'];

    uint8 tagType = uint8(data[ptr]);
    require(tagType < 11, "TAG");
    bytes memory svg = abi.encodePacked('<', tagMap[tagType], ' ');

    uint8 numProps = uint8(data[ptr + 1]);
    bytes memory propStr = "";
    ptr += 2;

    for (uint8 prop=0; prop<numProps; prop++) {
      // 'int', 'float', 'string', 'stroke', 'fill', 'd', 'points', 'transform', 'style', 'display'
      uint8 propIdx = uint8(data[ptr]);
      if (propIdx == 0) {
        // INT: Signed 2-byte integer
        (ptr, propStr) = FurDefs.renderInt(ptr + 1, data);
      } else if (propIdx == 1) {
        // FLOAT: Same as a signed 2-byte integer, except divided by 1000
        (ptr, propStr) = FurDefs.renderFloat(ptr + 1, data);
      } else if (propIdx == 2) {
        // STRING
        (ptr, propStr) = FurDefs.renderStr(ptr + 1, data);
      } else if (propIdx == 3) {
        // STROKE
        (ptr, propStr) = _renderStroke(ptr + 1, data, palette);
      } else if (propIdx == 4) {
        // FILL
        bytes memory colorStr = "";
        (ptr, colorStr) = _renderColor(ptr + 1, data, palette);
        propStr = abi.encodePacked('fill="', colorStr, '" ');
      } else if (propIdx == 5) {
        // D (PATH)
        propStr = abi.encodePacked('d="', _paths[uint8(data[ptr + 1])].path(uint8(data[ptr + 2])),'" ');
        ptr+=3;
      } else if (propIdx == 6) {
        // POINTS
        (ptr, propStr) = FurDefs.renderPoints(ptr + 1, data);
      } else if (propIdx == 7) {
        // TRANSFORM
        (ptr, propStr) = FurDefs.renderTransform(ptr + 1, data);
      } else if (propIdx == 8) {
        // STYLE
        (ptr, propStr) = _renderStyle(ptr + 1, data, palette);
      } else if (propIdx == 9) {
        // DISPLAY
        (ptr, propStr) = FurDefs.renderDisplay(ptr + 1, data);
      } else {
        require(false, "PROP");
      }
      svg = abi.encodePacked(svg, propStr);
    }

    uint8 numChildren = uint8(data[ptr]);
    ptr++;
    if (numChildren == 0) {
      return (ptr, abi.encodePacked(svg, '/>'));
    }

    bytes memory child = "";
    svg = abi.encodePacked(svg, '>');
    for (uint8 ch = 0; ch < numChildren; ch++) {
      (ptr, child) = _renderTag(ptr, data, palette);
      svg = abi.encodePacked(svg, child);
    }
    svg = abi.encodePacked(svg, '</', tagMap[tagType], '>');
    return (ptr, svg);
  }

  function _renderStroke(uint64 ptr, bytes memory data, uint8 palette) internal view returns (uint64, bytes memory) {
    uint8 t = uint8(data[ptr]);
    string[5] memory strokeMap = ['stroke', 'stroke-linecap', 'stroke-linejoin', 'stroke-width', 'stroke-miterlimit'];
    if (t == 0) {
      bytes memory col = "";
      (ptr, col) = _renderColor(ptr + 1, data, palette);
      return (ptr, abi.encodePacked('stroke="', col, '" '));
    } else if (t == 1 || t == 2) {
      string[8] memory joiners = ['crop', 'arcs', 'miter', 'bevel', 'round', 'fallback', 'butt', 'square'];
      return (ptr + 2, abi.encodePacked(strokeMap[t], '="', joiners[uint8(data[ptr + 1])], '" '));
    } else if (t == 3 || t == 4) {
      return (ptr + 2, abi.encodePacked(strokeMap[t], '="', FurLib.uint2str(uint8(data[ptr + 1])), '" '));
    }
    require(false, "STROKE");
  }

  function _renderStyle(uint64 ptr, bytes memory data, uint8 palette) internal view returns (uint64, bytes memory) {
    uint8 cnt = uint8(data[ptr]);
    ptr++;
    bytes memory vals = "";
    bytes memory innerVal = "";
    for (uint8 i=0; i<cnt; i++) {
      uint8 t = uint8(data[ptr]);
      if (t == 0) {
        (ptr, innerVal) = _renderColor(ptr + 1, data, palette);
        vals = abi.encodePacked(vals, 'stop-color:', innerVal, i == (cnt - 1) ? '' : ';');
      } else if (t == 1) {
        (ptr, innerVal) = FurDefs.unpackFloat(ptr + 1, data);
        vals = abi.encodePacked(vals, 'stop-opacity:', innerVal, i == (cnt - 1) ? '' : ';');
      } else {
        require(false, "STYLE");
      }
    }
    return (ptr, abi.encodePacked('style="', vals, '" '));
  }

  function _renderColor(uint64 ptr, bytes memory data, uint8 palette) internal view returns(uint64, bytes memory) {
    uint8 t = uint8(data[ptr]);
    if (t == 0) return (ptr + 1, "none");
    if (t == 1) {
      bytes memory alphabet = "0123456789abcdef";
      return (ptr + 4, abi.encodePacked(
        '#',
        alphabet[uint(uint8(data[ptr + 1] >> 4))],
        alphabet[uint(uint8(data[ptr + 1] & 0x0f))],
        alphabet[uint(uint8(data[ptr + 2] >> 4))],
        alphabet[uint(uint8(data[ptr + 2] & 0x0f))],
        alphabet[uint(uint8(data[ptr + 3] >> 4))],
        alphabet[uint(uint8(data[ptr + 3] & 0x0f))]
      ));
    }
    if (t == 2) {
      bytes memory id = "";
      (ptr, id) = FurDefs.unpackStr(ptr + 1, data);
      return (ptr, abi.encodePacked('url(#', id, ')'));
    }
    if (t == 3) return (ptr + 1, "#000000");
    if (t == 4) return (ptr + 1, "#FFFFFF");
    if (t == 5) return (ptr + 1, abi.encodePacked('#', _palette.primaryColor(palette)));
    if (t == 6) return (ptr + 1, abi.encodePacked('#', _palette.secondaryColor(palette)));
    require(false, "COL");
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
    return
      interfaceId == type(IFurballEdition).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  modifier onlyAdmin() {
    require((address(furballs) == address(0) && _owner == msg.sender) || furballs.isAdmin(msg.sender));
    _;
  }
}
