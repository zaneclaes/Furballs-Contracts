// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "./IFurballEdition.sol";
import "../Furballs.sol";
import "../utils/FurLib.sol";
import "../utils/FurDefs.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "./IFurballPart.sol";
import "./IFurballPaths.sol";
import "./IFurballPalette.sol";
import "hardhat/console.sol";

/// @title FurballEdition
/// @author LFG Gaming LLC
/// @notice Base class for a furball edition with common implementations
abstract contract FurballEdition is ERC165, IFurballEdition {
  // Is this edition live?
  bool public override live = false;

  // How many exist in this edition?
  uint32 public override count = 0;

  // The names of the slots used by this edition
  string[] public slots;

  // How many has each wallet minted in this edition?
  mapping(address => uint32) public override minted;

  mapping(string => IFurballPart) private _parts;

  IFurballPalette private _palette;

  mapping(address => uint32) internal _whitelist;

  mapping(uint256 => string) internal _names;

  IFurballPaths[] private _paths;

  Furballs public furballs;

  function getRewardModifiers(
    uint256 tokenId, uint16 level, uint32 zone
  ) external override virtual view returns(FurLib.RewardModifiers memory) {
    return FurDefs.baseModifiers(level, _getRarityBoostPoints(tokenId), zone);
  }

  constructor(
    address furballsAddress, address paletteAddress, address[] memory partsAddresses, address[] memory pathsAddresses
  ) {
    furballs = Furballs(payable(furballsAddress));
    _palette = IFurballPalette(paletteAddress);
    for (uint256 i=0; i<partsAddresses.length; i++) {
      IFurballPart part = IFurballPart(partsAddresses[i]);
      string memory slot = part.slot();
      require(address(_parts[slot]) == address(0), 'PART');
      slots.push(slot);
      _parts[slot] = part;
    }
    for (uint256 i=0; i<pathsAddresses.length; i++) {
      IFurballPaths paths = IFurballPaths(pathsAddresses[i]);
      _paths.push(paths);
    }
  }

  function tokenData(
    uint256 tokenId, uint256 number, uint64 birth, bytes memory attributes
  ) external virtual override view returns(bytes memory) {
    attributes = abi.encodePacked(
      '[',
        attributes,
        _getAttributes(tokenId),
        // '{"display_type": "date", "trait_type": "Acquired", "value": ', FurLib.uint2str(furballs[tokenId].trade),
        '{"display_type": "date", "trait_type": "Birthday", "value": ', FurLib.uint2str(birth),
      '}]'
    );

    return abi.encodePacked(
      '{"name": "', _getName(tokenId, number),
        '", "external_url": "https://furballs.com/#/furball/', FurLib.bytesHex(abi.encodePacked(tokenId)),
        '", "background_color": "', _palette.backgroundColor(FurLib.extractByte(tokenId, 2)),
        '", "image": "data:image/svg+xml;base64,', FurLib.encode(_render(tokenId)),
        '", "attributes": ', attributes,
      '}'
    );
  }

  function _getName(uint256 tokenId, uint256 number) internal virtual view returns(string memory) {
    string memory name = _names[tokenId];
    if (bytes(name).length > 0) return name;
    return string(abi.encodePacked("Furball #", FurLib.uint2str(number)));
  }

  function setNames(uint256[] memory tokenIds, string[] memory names) external {
    require(furballs.isModerator(msg.sender) || furballs.isAdmin(msg.sender));
    require(tokenIds.length == names.length, 'LEN');
    for (uint256 i=0; i<tokenIds.length; i++) {
      _names[tokenIds[i]] = names[i];
    }
  }

  function addCount(address to, uint32 amount) external override returns(bool) {
    require(furballs.isAdmin(msg.sender) || msg.sender == address(furballs));
    count += amount;
    minted[to] += amount;
    return true;
  }

  function numSlots() external virtual view override returns(uint8) {
    return uint8(slots.length);
  }

  function numParts(uint8 slot) external virtual view override returns(uint8) {
    return _parts[slots[slot]].count();
  }

  function setLive(bool goLive) public onlyAdmin {
    require(live != goLive, 'LIVE');
    live = goLive;
  }

  function addToWhitelist(address[] memory addresses, uint32 num) public onlyAdmin {
    for (uint256 i=0; i<addresses.length; i++) {
      _whitelist[addresses[i]] = num;
    }
  }

  function _getAttributes(uint256 tokenId) internal virtual view returns (string memory) {
    uint32 boost = _getRarityBoostPoints(tokenId);
    bytes memory ret = "";
    // abi.encodePacked(
    //     '{"display_type": "boost_percentage", "trait_type": "Rarity", "value": ',
    //     FurLib.uint2str(boost),'},');
    for (uint8 slot=0; slot<slots.length; slot++) {
      uint8 idx = _extractSlotNumber(tokenId, slot);
      if (idx == 0) continue;
      idx--;

      ret = abi.encodePacked(ret, FurLib.trait(slots[slot],
        string(abi.encodePacked(
          _parts[slots[slot]].name(idx),
          FurDefs.raritySuffix(_getRarity(slot, idx))
        ))
      ));
    }
    return string(ret);
  }

  function spawn() external override returns (uint256) {
    uint8 palette = uint8(furballs.maths().roll(0) % _palette.numPalettes());
    uint8 bk = uint8(furballs.maths().roll(0) % _palette.numBackgroundColors());
    uint256 ret = (bk * (256 ** 2)) + (palette * 256);
    for (uint8 slot=0; slot<slots.length; slot++) {
      ret += _rollSlot(slot) * (256 ** (slot + 3));
    }
    return ret;
  }

  function _extractSlotNumber(uint256 tokenId, uint8 slot) internal pure returns(uint8) {
    return FurLib.extractByte(tokenId, slot + 3);
  }

  function rollRarity(uint32 seed) public returns(uint8) {
    uint32 rolled = furballs.maths().roll(seed);
    uint32[4] memory rarities = [
      FurLib.Max32 / 1000 * 738, // 20%
      FurLib.Max32 / 1000 * 938, // 5%
      FurLib.Max32 / 1000 * 988, // 1%
      FurLib.Max32 / 1000 * 998  // 0.2%
    ];
    for (uint8 r=4; r>0; r--) {
      if (rolled > rarities[r - 1]) {
        return r;
      }
    }
    return 0;
  }

  function _rollSlot(uint8 i) internal returns(uint256) {
    uint8 rarity = rollRarity(0);
    uint8[] memory opts = _parts[slots[uint(i)]].options(rarity);
    if (opts.length == 0) {
      if (rarity != 0) {
        // Rolled a rare attribute, but there were no options. Re-try this roll.
        return _rollSlot(i);
      }
      // This is a null slot.
      return 0;
    }
    return (furballs.maths().roll(0) % opts.length) + 1;
  }

  /// @notice Rarity is in points (i.e., 1%s)
  function _getRarityBoostPoints(uint256 tokenId) internal virtual view returns (uint32) {
    uint32 boost = 0;
    for (uint8 slot=0; slot<slots.length; slot++) {
      uint8 idx = _extractSlotNumber(tokenId, slot);
      if (idx == 0) continue;
      idx--;
      boost += uint32(_getRarity(slot, idx) * 5);
    }
    return boost;
  }

  function _getRarity(uint8 slot, uint8 idx) internal virtual view returns(uint8) {
    for (uint8 rarity = 1; rarity <= 4; rarity++) {
      uint8[] memory opts = _parts[slots[slot]].options(rarity);
      for (uint8 o=0; o<opts.length; o++) {
        if (opts[o] == idx) {
          return rarity;
        }
      }
    }
    return 0;
  }

  function _render(uint256 tokenId) internal virtual view returns (bytes memory) {
    uint8 palette = FurLib.extractByte(tokenId, 1);
    bytes memory ret = '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 350 350" style="enable-background:new 0 0 350 350;" xml:space="preserve">';
    for (uint8 slot=0; slot<slots.length; slot++) {
      uint8 idx = _extractSlotNumber(tokenId, slot);
      if (idx == 0) continue;
      ret = abi.encodePacked(ret, renderSlot(slot, idx - 1, palette));
    }
    return abi.encodePacked(ret, '</svg>');
  }

  function renderSlot(uint8 slot, uint8 index, uint8 palette) public view returns(string memory) {
    bytes memory svg = '';
    bytes memory tag;
    bytes memory data = _parts[slots[slot]].data();
    uint64 ptr = _pointer(data, index, true) + 3;
    uint8 numTags = uint8(data[ptr - 1]);
    for (uint8 t=0; t < numTags; t++) {
      (ptr, tag) = _renderTag(ptr, data, palette);
      svg = abi.encodePacked(svg, tag);
    }
    return string(svg);
  }

  function _pointer(bytes memory data, uint8 index, bool twoByte) internal pure returns(uint64) {
    if (index == 0) return 0;
    uint64 ptr = 0;
    for (uint256 i=0; i<index; i++) {
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
    require(tagType < 11, 'TAG');
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
        require(false, string(abi.encodePacked('PROP', FurLib.uint2str(propIdx))));
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
    require(false, 'STROKE');
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
        require(false, 'STYLE');
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
    require(false, 'COL');
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
    return
      interfaceId == type(IFurballEdition).interfaceId ||
      super.supportsInterface(interfaceId);
  }

  modifier onlyAdmin() {
    require(furballs.isAdmin(msg.sender));
    _;
  }
}
