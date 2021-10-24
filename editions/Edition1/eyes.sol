// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPart.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1eyes is IFurballPart {
  mapping(uint8 => uint8[]) private _options;

  constructor() {
    _options[0].push(0);
    _options[0].push(1);
    _options[0].push(2);
    _options[0].push(3);
    _options[0].push(4);
    _options[0].push(5);
    _options[0].push(6);
    _options[0].push(7);
    _options[3].push(8);
    _options[0].push(9);
    _options[1].push(10);
    _options[2].push(11);
    _options[2].push(12);
    _options[0].push(13);
    _options[0].push(14);
    _options[0].push(15);
    _options[0].push(16);
    _options[0].push(17);
    _options[0].push(18);
  }

  function slot() external pure override returns(string memory) {
    return "Eyes";
  }

  function options(uint8 rarity) external view override returns(uint8[] memory) {
    return _options[rarity];
  }

  function name(uint8 idx) external pure override returns(string memory) {
    if (idx == 0) return "Googley";
    if (idx == 1) return "Angry";
    if (idx == 2) return "Lazy";
    if (idx == 3) return "Creepy";
    if (idx == 4) return "Monicle";
    if (idx == 5) return "Vapor";
    if (idx == 6) return "Skeptical Blue";
    if (idx == 7) return "Skeptical Red";
    if (idx == 8) return "Skeptical Rainbow";
    if (idx == 9) return "Sparkle Blue";
    if (idx == 10) return "Sparkle Pink";
    if (idx == 11) return "Spider";
    if (idx == 12) return "Stars";
    if (idx == 13) return "Oh No";
    if (idx == 14) return "Evil";
    if (idx == 15) return "Goofy";
    if (idx == 16) return "Chill";
    if (idx == 17) return "Worry Green Purple";
    if (idx == 18) return "Worry Silver";
    return "";
  }

  function count() external pure override returns(uint8) {
    return uint8(19);
  }

  function data() external pure override returns(bytes memory) {
    return hex"01cf10060105002b00060105002c00020501000120000000ea0001009700090013000a00140001040404000000e80001008f00080017000406020002413502020e7573657253706163654f6e557365000300ef0006009e000400ef0007007e050902010104128408010001ffd0e4000902010104260408010001ffd0e4000902010104384908010001f6d5e8000902010104587408010001dee1f2000902010104765808010001c3effd0001040402024135000000ef0001008e0008000f000103000000ef0001008e0008000b000602040405002d000107040003000303030403040a000000e80001008f00080017000205010001200000009e0001009600090015000a00160001040404000000a10001008f00080017000406020002423502020e7573657253706163654f6e5573650003009a0006009e0004009a0007007e050902010104128408010001ffd0e4000902010104260408010001ffd0e4000902010104384908010001f6d5e8000902010104587408010001dee1f2000902010104765808010001c3effd00010404020242350000009a0001008e0008000f0001030000009a0001008e0008000b000602040405002e000107040003000303030403040a000000a10001008f000800170001ef1006010500900006010500910002070200024135010002130201036e6577000000ea0001009700090013000a001400010502000242350404000000e80001008f00080017000407020002433502020e7573657253706163654f6e557365000300ef000600bf000400ef000700df0203166d6174726978283120302030202d3120302033353029020902010104062308010001dfd0ff000902010104512408010001ff878700010502000244350402024335000000ef0001008e0008000f0001040200024535000000ef0001008e0008000b000603020002463504040501000001080200024735040003000303030403040a000000e80001008f000800170002070200024835010002130201036e6577000000a30001009700090013000a001400010502000249350404000000a00001008f000800170004070200024a3502020e7573657253706163654f6e557365000300a8000600bf000400a8000700df0203166d6174726978283120302030202d3120302033353029020902010104062308010001dfd0ff000902010104512408010001ff87870001050200024b350402024a35000000a80001008e0008000f0001040200024c35000000a80001008e0008000b0006030200024d3504040501010001080200024e35040003000303030403040a000000a00001008f000800170001230f0602040405013a000205010002150000009e0001009600090015000a001600020501000215000000ea0001009700090013000a00140001040404000000e80001008f000800170001040404000000a10001008f000800170001040401bdefff000000a6000100920008000c000103000000a600010092000800080001040404000000a700010096000800020001040401bdefff000000e3000100920008000c000103000000e300010092000800080001040404000000e40001009600080002000107040003000303030403040a000000e80001008f00080017000107040003000303030403040a000000a10001008f00080017000607040503000303030403010403020403040a05013b000607040503000303030403010403020403040a05013c0001df0e0205010002150000009e0001009600090015000a001600020501000215000000ea0001009700090013000a00140001040404000000e80001008f000800170001040404000000a10001008f00080017000406020002413502020e7573657253706163654f6e557365000300a20006009b000400a20007007f050902010104500908010001c2ff97000902010104628908010001c6fe96000902010104756708010001d2fb94000902010104884108010001e6f6910009020101800108010001ffef8c0001040402024135000000a20001008d0008000d000103000000a20001008d00080009000406020002423502020e7573657253706163654f6e557365000300e60006009b000400e60007007f050902010104500908010001c2ff97000902010104628908010001c6fe96000902010104756708010001d2fb94000902010104884108010001e6f6910009020101800108010001ffef8c0001040402024235000000e60001008d0008000d000103000000e60001008d00080009000107040003000303030403040a000000e80001008f00080017000107040003000303030403040a000000a10001008f00080017000607040503000303030403010403020403040a050163000607040503000303030403010403020403040a05016400012410020501000120000000ec0001009700090013000a00140006070401ebb82a03000303030203010403020403040a0502520006020401ebb82a0502530001040401b8e7fc000000e90001008f00080010000109040003000303030303010403020403040a000000e90001008f000800170006020401caedfc0502540006020401caedfc050255000109040003000303030303010403020403040a000000e90001008f0008001000030a040003000303030203010403020403040a000300ff000600a2000400fa000700a800030a040003000303030203010403020403040a000300ff000600a9000400fa000700af000607040003000303030403010403020403040a05025600060105025700060105025800060105025900060105025a00060105025b0000b30a020501000216000000ea0001009700090013000a0014000205010002160000009e0001009600090015000a00160001040404000000a10001008d00080018000103000000a10001008d000800130006020404050323000107040003000303030403040a000000a10001008d000800180001040404000000e80001008d00080018000103000000e80001008d000800130006020404050324000107040003000303030403040a000000e80001008d000800180001750f0205010001200000009e0001009600090015000a00160001040404000000a10001008f00080017000406020002413502020e7573657253706163654f6e557365000300a10006009f000400a10007007f030902010100080100015acbf500090201010442640801000172e3ee00090201018001080100018fffe50001040402024135000000a10001008f0008000f000103000000a10001008f0008000b0006020404050409000107040003000303030403040a000000a10001008f0008001700060105040a000602040405040b000406020002423502020e7573657253706163654f6e557365000300e800060099000400e80007007f030902010100080100015acbf500090201010442640801000172e3ee00090201018001080100018fffe5000602040202423505040c000103000000e80001008f000800070001040404000000ec0001008c00080002000605040003000303030403040a05040d000607040003000303030403010403020403040a05040e0001930f0205010001200000009e0001009600090015000a00160001040404000000a10001008f00080017000406020002413502020e7573657253706163654f6e557365000300a10006009f000400a10007007f04090201010008010001f54a4a000902010104384308010001fb5391000902010104764208010001fe896d0009020101800108010001ffa6590001040402024135000000a10001008f0008000f000103000000a10001008f0008000b0006020404050409000107040003000303030403040a000000a10001008f0008001700060105040a000602040405040b000406020002423502020e7573657253706163654f6e557365000300e800060099000400e80007007f04090201010008010001f54a4a000902010104384308010001fb5391000902010104764208010001fe896d0009020101800108010001ffa659000602040202423505040c000103000000e80001008f000800070001040404000000ec0001008c00080002000605040003000303030403040a05040d000607040003000303030403010403020403040a05040e0001c4230205010001200000009e0001009600090015000a00160001040404000000a10001008f00080017000107040003000303030403040a000000a10001008f0008001700060105040a000602040405040b00060504016c5fb3030001d2c9ff03030003040a05040f0006020401d2ff7a0504100006020401d2ff7a05041100060204017bffff0504120006020401d2c9ff0504130006020401d2ff7a05041400060204017bffff0504150006020401d2ff7a0504160006020401d2ff7a05041700060204017bffff0504180006020401d2c9ff0504190006020401d2ff7a05041a0006020401d2c9ff05041b00060204017bffff05041c000103000000a10001008f0008000b000602040405041d00060204017bffff05041e0006020401d2c9ff05041f0006020401d2ff7a0504200006020401d2ff7a0504210006020401d2c9ff0504220006020401d2ff7a0504230006020401d2ff7a05042400060204017bffff05042500060204017bffff05042600060204017bffff050427000103000000e80001008f000800070001040404000000eb0001008d00080002000605040003000303030403040a05040d000607040003000303030403010403020403040a05040e0002190e02070200024135010002130201036e6577000000a30001009700090013000a001400010502000242350404000000a00001008f00080017000407020002433502020e7573657253706163654f6e557365000300a00006f691000400a00007f6b80203186d6174726978283120302030202d312030202d323234382902090201010406230801000163fff700090201018001080100016265fb00010502000244350402024335000000a000010094000800130001040200024535000000a0000100990008000c0001080200024635040003000303030403040a000000a00001008f000800170002070200024735010002130201036e6577000000ea0001009700090013000a001400010502000248350404000000e80001008f00080017000407020002493502020e7573657253706163654f6e557365000300e80006f691000400e80007f6b80203186d6174726978283120302030202d312030202d323234382902090201010406230801000163fff700090201018001080100016265fb0001050200024a350402024935000000e800010094000800130001040200024b35000000e8000100990008000c0001080200024c35040003000303030403040a000000e80001008f000800170007020404060800a2009a00a8009900a2009700a00091009e009700980099009e009a00a000a00007020404060800ea009a00ef009900ea009700e8009100e6009700e0009900e6009a00e800a00001e50e02070200024135010002130201036e6577000000a30001009700090013000a001400010502000242350404000000a00001008f00080017000406020002433502020e7573657253706163654f6e557365000300a0000600a7000400a000070080020902010104315308010001ff78c2000902010104870708010001eab0ff00010502000244350402024335000000a000010094000800130001040200024535000000a0000100990008000c0001080200024635040003000303030403040a000000a00001008f000800170002070200024735010002130201036e6577000000ea0001009700090013000a001400010502000248350404000000e80001008f00080017000406020002493502020e7573657253706163654f6e557365000300e8000600a7000400e800070080020902010104315308010001ff78c2000902010104870708010001eab0ff0001050200024a350402024935000000e800010094000800130001040200024b35000000e8000100990008000c0001080200024c35040003000303030403040a000000e80001008f000800170007020404060800a2009a00a8009900a2009700a00091009e009700980099009e009a00a000a00007020404060800ea009a00ef009900ea009700e8009100e6009700e0009900e6009a00e800a00005112402060200024135040400000094000100890009000a000a000a000407020002423502020e7573657253706163654f6e557365000300980006f6a8000400980007f6b60203186d6174726978283120302030202d312030202d3232343829020902010104062308010001daffa400090201010451240801000184ffc000020602000243350402024235000000980001008900090007000a00070002050200024435000000980001008900090005000a0005000603020002453504040504280002090200024635040003000303030403040a00000094000100890009000a000a000a00020602000247350404000000ac0001008a0009000a000a000a000407020002483502020e7573657253706163654f6e557365000300af0006f6a7000400af0007f6b60203186d6174726978283120302030202d312030202d3232343829020902010104062308010001d6c2ff000902010104512408010001fb707400020602000249350402024835000000af0001008a00090007000a00070002050200024a35000000af0001008a00090005000a00050006030200024b3504040504290002090200024c35040003000303030403040a000000ac0001008a0009000a000a000a0002060200024d350404000000a00001009c0009000a000a000a0004060200024e3502020e7573657253706163654f6e557365000300a3000600a3000400a300070094020902010104186708010001abffff000902010104604908010001c0adff0002060200024f350402024e35000000a30001009b00090007000a00070002050200025035000000a30001009b00090005000a00050006030200025135040405042a0002090200025235040003000303030403040a000000a00001009c0009000a000a000a00020602000253350404000000db000100890009000a000a000a000407020002543502020e7573657253706163654f6e557365000300de0006f6a8000400de0007f6b60203186d6174726978283120302030202d312030202d3232343829020902010104062308010001d6c2ff000902010104512408010001fb707400020602000255350402025435000000de0001008900090007000a00070002050200025635000000de0001008900090005000a00050006030200025735040405042b0002090200025835040003000303030403040a000000db000100890009000a000a000a00020602000259350404000000f20001008a0009000a000a000a0004070200025a3502020e7573657253706163654f6e557365000300f50006f6a7000400f50007f6b60203186d6174726978283120302030202d312030202d3232343829020902010104186708010001abffff000902010104604908010001c0adff00020602000230350402025a35000000f50001008a00090007000a00070002050200023135000000f50001008a00090005000a00050006030200023235040405042c0002090200023335040003000303030403040a000000f20001008a0009000a000a000a00020602000234350404000000e60001009c0009000a000a000a000406020002353502020e7573657253706163654f6e557365000300e9000600a3000400e900070094020902010104062308010001daffa400090201010451240801000184ffc000020602000236350402023535000000e90001009b00090007000a00070002050200023735000000e90001009b00090005000a00050006030200023835040405042d0002090200023935040003000303030403040a000000e60001009c0009000a000a000a00005b0606070401ffe96703000303030403010403020403040a05050a000602040405050b0006020401ffe96705050c0006070401ffe96703000303030403010403020403040a05050d000602040405050e0006020401ffe96705050f0000ed0c0205010002150000009e0001009600090015000a001600020501000215000000ea0001009700090013000a00140001040404000000a10001008f00080017000104040199e6ff000000a6000100900008000e000103000000a6000100900008000a0001040404000000a700010095000800020001040404000000e80001008f00080017000107040003000303030403040a000000e80001008f00080017000107040003000303030403040a000000a10001008f00080017000104040199e6ff000000e4000100900008000e000103000000e4000100900008000a0001040404000000e500010095000800020000f90e0205010001400000009e0001009600090015000a001600020501000140000000ea0001009700090013000a00140001040404000000a10001008f000800170001040401fa4f45000000a30001009100080013000103000000a5000100940008000f0001040404000000ae0001008700080008000107040003000303030403040a000000a10001008f000800170001040404000000e80001008f000800170001040401fa4f45000000e60001009100080013000103000000e4000100940008000f0001040404000000f40001008700080008000107040003000303030403040a000000e80001008f000800170006010505250006010505260001230c0205010002150000009e0001009600090015000a001600020501000215000000ea0001009700090013000a00140001040404000000a10001008f00080017000104040199ffd30000009e00010091000800110001030000009e000100910008000c00010404040000009f00010097000800030001040404000000e80001008f00080017000107040003000303030403040a000000a10001008f000800170002060706044115149114049114044115840c6001a401233939040199ffd3000000e7000100870009000e000a000e0002050706044115149114049114044115840c6001a401233939000000e7000100870009000a000a000a0001040404000000ea0001008300080002000107040003000303030403040a000000e80001008f00080017000126080607040196fff403000303030403010403020403040a05052700020607060900397876309001800109003978763084165185a4013521810401162625000000a60001008f00090013000a00130002060706800119004212874009004212874080011460270495950401162625000000e30001008f00090013000a0013000603010001600401354f4d050528000603010001600401354f4d050529000603010001600401354f4d05052a00020b07060900397876309001800109003978763084165185a401352181040003000303030403010403020403040a000000a60001008f00090013000a001300020b070680011900421287400900421287408001146027049595040003000303030403010403020403040a000000e30001008f00090013000a00130001f510020501000120000000ea0001009900090013000a0014000205010001200000009e0001009700090015000a00160006020404050623000607040003000303030403010403020403040a050624000406020002413502020e7573657253706163654f6e557365000300a7000600a7000400a700070087060902010104147208010001784ce00009020101042417080100017564d80009020101045039080100016da0c300090201010472680801000168cdb300090201010489920801000164e8aa000902010180010801000163f2a60006020402024135050625000103000000a8000100990008000c0006020404050626000605040003000303030403040a0506230006020404050627000607040003000303030403010403020403040a050628000407020002423502020e7573657253706163654f6e5573650003ff90000600a70004ff900007008702031b6d6174726978282d31203020302031203131332e38383035203029060902010104147208010001784ce00009020101042417080100017564d80009020101045039080100016da0c300090201010472680801000168cdb300090201010489920801000164e8aa000902010180010801000163f2a60006020402024235050629000103000000e1000100990008000c000602040405062a000605040003000303030403040a05062700015910020501000120000000ea0001009900090013000a0014000205010001200000009e0001009700090015000a00160006020404050623000607040003000303030403010403020403040a0506240005050200024135000000a7000100970008001002020e7573657253706163654f6e557365020902010104355908010001d3cfdb000902010104939508010001a09da60006020402024135050625000103000000a8000100990008000c0006020404050626000605040003000303030403040a0506230006020404050627000607040003000303030403010403020403040a0506280005050200024235000000e2000100970008001002020e7573657253706163654f6e557365020902010104355908010001d3cfdb000902010104939508010001a09da60006020402024235050629000103000000e1000100990008000c000602040405062a000605040003000303030403040a05062700";
  }
}