// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPart.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1weapon is IFurballPart {
  mapping(uint8 => uint8[]) private _options;

  constructor() {
    _options[0].push(0);
    _options[0].push(1);
    _options[0].push(2);
    _options[0].push(3);
    _options[0].push(4);
    _options[1].push(5);
    _options[0].push(6);
    _options[3].push(7);
    _options[2].push(8);
    _options[0].push(9);
    _options[0].push(10);
    _options[0].push(11);
  }

  function slot() external pure override returns(string memory) {
    return "Weapon";
  }

  function options(uint8 rarity) external view override returns(uint8[] memory) {
    return _options[rarity];
  }

  function name(uint8 idx) external pure override returns(string memory) {
    if (idx == 0) return "Asparagus Spear";
    if (idx == 1) return "Butter Knife";
    if (idx == 2) return "Poop Squasher";
    if (idx == 3) return "Sad Pencil";
    if (idx == 4) return "Pyro Stick";
    if (idx == 5) return "Straw of Death";
    if (idx == 6) return "Spork Dork";
    if (idx == 7) return "Whimsy Wand";
    if (idx == 8) return "Fur Reaper";
    if (idx == 9) return "Stabby Thing";
    if (idx == 10) return "ExeQtioner";
    if (idx == 11) return "Bubble Wand";
    return "";
  }

  function count() external pure override returns(uint8) {
    return uint8(12);
  }

  function data() external pure override returns(bytes memory) {
    return hex"01b41206070401b288b803000303030303010403020403040a0500010006070401b288b803000303030303010403020403040a0500020006070401b288b803000303030303010403020403040a0500030006020401a8e0800500040006020401ccffa8050005000607040003000303030403010403020403040a0500040006070401b2978803000303030303010403020403040a0500060006070401b288b803000303030303010403020403040a0500070006070401b2978803000303030303010403020403040a0500080006070401b2c58803000303030303010403020403040a0500090006070401b2978803000303030303010403020403040a05000a0006070401b2c58803000303030303010403020403040a05000b0006070401b2c58803000303030303010403020403040a05000c0006070401b2c58803000303030303010403020403040a05000d0006070401b2c58803000303030403010403020403040a05000e0006070401b2c58803000303030303010403020403040a05000f0006070401b2c58803000303030303010403020403040a0500100006070401b2c58803000303030303010403020403040a0500110000590606020401ffa6d305004b0006020401e2f3f605004c0006020401f1fafb05004d000001010002780106020401ffa6d305004e000605040003000303030503040a05004f0006050401bae9ff03000303030403040a05005000014e0d06020401ffea9305010b000603010001900401f8d27605010c000605040003000303030403040a05010d0006020401ffa6d305010e0006020401ff80c005010f000605040003000303030403040a05010e0006020401ffa6d30501100006020401ff80c0050111000607040003000303030403010403020403040a050112000206070604211914977304977304211984ab2664a4014670190401ffbfdf00000120000100390009000c000a002d000206070604211914977304977304211984ab2664a4014670190401ff80c0000001200001003900090005000a001f00020b070604211914977304977304211984ab2664a401467019040003000303030303010403020403040a000001200001003900090005000a001f000209070604211914977304977304211984ab2664a401467019040003000303030403040a00000120000100390009000c000a002d0000b50f06020401ffa6d305014a000602040405014b00060105014c0006020401ffa6d305014a0006020401f0faff05014d0006020401ffb26105014e0006020401ffc2e105014f00060204040501500006020401ffb2610501510006020401ffc68a0501520006020401ffc68a050153000605040003000303030403040a0501540001030000011d00010052000800020001030000012c0001005700080002000607040003000303030203010403020403040a0501550000a80a06020401ffe67f0501740006020401ffbd7f0501750006020401c5c5fe050176000607040003000303030403010403020403040a0501770007020401c7673c060500f2012800eb012c00e9012a0123007c012a007f0007020401ffb88c060400eb012b00da0124011d007b0124007e000603010002570401ba7447050178000607040003000303030403010403020403040a05017900060105020000060204014752540502010000d3100602040405027000060204017dffdf05027100060204017dffdf05027200060301000235040405027300060204017dffdf05027400060204017dffdf05027500060204017dffdf05027600060204017dffdf05027700060204017dffdf050278000603010002290401548f8105027900060204017dffdf05027a000607040003000303030403010403020403040a050270000603010002290401548f8105027b000602040405027c000001010002290106020401548f8105027c000607040003000303030303010403020403040a05027d00007e0706020401dbeff305027e0006020401c3d8db05027f0006020401f6f6f60502800002060706043111149504049504043111847a7764a40143322804040000011c0001004c00090007000a00020006020401c3d8db050281000605040003000303030403040a05028200060504019effc003000303030403040a05028300021e140001010001300306020401ff93ff0503590006020401ffff5a05035a00060204013fff7305035b0006020401eb9bf605035c000407020002413102020e7573657253706163654f6e557365000300e8000600d700040136000700d70203366d617472697828302e3937313420302e32333735202d302e3233373520302e393731342037372e32353536202d3139332e353535392902090201010008010001b34aef0009020101800108010001de6ff2000602040202413105035d0006020401b34aef05035e0006020401b34aef05035f000607040003000303030403010403020403040a05035c0006020401db95f10503600006020401e9cff10503610006020401d374f1050362000607040003000303030403010403020403040a050363000603010002410401e3b5f1050364000702040181d2ff060400f4010800f3010e00f6011100fc010f0007020401ae66fc060400f5011500fa011800fc010f00f60111000702040181d2ff060400f5011500f0011600ee011e00fa01180007020401aafbff060400f0011600ee011300e8011300ee011e0007020401b2f6ff060400ee011000f3010e00f4010800ea010b0007020404060800f3010e00ee011000ea010b00e8011300ee011300f0011600f5011500f60111000707040003000303030303010403020403040a060600fa011800fc010f00f4010800ea010b00e8011300ee011e000607040003000303030403010403020403040a0503640000b00a07020401a3a6a6060400f2012800e9012a01270074012f00740007020401c6c9ca060400eb012b00da012401220070012a0073000607040003000303030403010403020403040a05046700060204018a8c8d05046800060704018a8c8d03000303030303010403020403040a05046900060204016c6e7005046a00060204018a8c8d05046b00060301000120040405046c00060105046d000607040003000303030303010403020403040a05046e00011d0e06060401ca362c03000303030403010403040a05046f0006020401a32a22050470000a0600020104000500510706049603042791142791049603832242409446354301000235000b0007000c00090007020100023506040144006b013d0069013f0064014700630006020401d9433a0504710006020401fa4f45050472000607040003000303030303010403020403040a0504730006020401d9433a0504740006020401fa4f45050475000a0600020128000500440706049603042791142791049603842024299450786201000235000b0007000c00090006020401d9433a0504760006020401fa4f45050477000607040003000303030303010403020403040a050478000607040003000303030303010403020403040a0504790000940a0602040405047a0006020401eceef005047b0006020401cfdbd905047c000607040003000303030403010403020403040a05047a000602040405047d0006020401eceef005047e0006020401cfdbd905047f000607040003000303030403010403020403040a0504800006070401c7dcf003000303030403010403020403040a050481000603010002290401447e6e0504820003711c0602040187ffe105060500070204013bffcf06040128004001290034012f0036012a004100070204013bffcf0604011a007f0118008b0113008a0118007e00070204013bffcf060401400067014c0068014b006e0140006900070204013bffcf06040102005900f5005700f700520102005600070204013bffcf0604013c004f014600470149004c013d005100070204013bffcf06040106007100fc007800f900740105006f00070204013bffcf06040132007b013a0085013500870130007c00070204013bffcf0604011000450108003b010d00380112004300070204013bffcf060401340046013a003b013e003f0136004700070204013bffcf0604010e007a0108008401040081010c007800070204013bffcf0604013b0072014600790142007d013a007400070204013bffcf06040107004d00fc0047010000420108004b00070204013bffcf06040141005a014c0057014d005d0141005d00070204013bffcf06040101006500f5006800f500630101006300070204013bffcf06040126007f0129008b0124008c0124008000070204013bffcf0604011c004001190034011e0034011e0040000602040172ffdc0506060007030100023204012cbf9b0604011a0096010d009101100088011d008c000607040003000303030403010403020403040a050607000607040003000303030403010403020403040a05060800020b07060470711470710470710470718410729184e88407040003000303030403010403020403040a00000121000100600009001e000a001e000407020002413102020e7573657253706163654f6e557365000300610006006200040138000700620203356d617472697828302e39373137202d302e3233363320302e3233363320302e39373137202d31332e323538322035322e38323236290409020101041223080100017bcdfd00090201010429120801000166f4ff00090201010467630801000189b8f2000902010104972908020001b0b0ff01016000060301000273040202413105060900060301000130040405060a000207070680011900563218100900563218108001144335047603010001300404000000860001004d00090009000a00090002070706046059147955047955046059842e1698a3010b565001000130040400000125000100570009000e000a000e00060701000130040003000403030d03010403040a05060b00";
  }
}