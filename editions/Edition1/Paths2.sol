// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPaths.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1Paths2 is IFurballPaths {
  function path(uint8 p) external pure override returns(bytes memory) {
    if (p == 0) return "M295 41.32s25.92 8.37 17.26 37.63c-3.82 12.89 1.84 16.57 4.81 16.2 1.28-.16 2.36-.9 2.92-1.89l6.01-9.4s26.25 52.05-31.99 58.69c0 0-28.73-.54-29.33-30.07-.26-12.61 7.1-28.3 7.1-26.9 0 1.4 8.66-9.47 20.92-22.78s2.3-21.48 2.3-21.48z";
    if (p == 1) return "M304.52 77.27c.84-5.39-11.92-5.02-18.68 4.98-5.52 8.17-14 22.56-15.07 30.29-1.38 10.02 4.92 19.94 5.39 21.06 7.93 2.43 18.87 8.39 18.87 8.39 7.72-.81-.41.12 4.97-1.75.31-.6 16.42-4.64 20.94-17.69 7.3-21.07-19.82-23.39-16.42-45.28z";
    if (p == 2) return "M294.04 95.44c-12.5 0-20.19 10.4-21.65 21.02-1.19 8.6 4.22 17.12 4.63 18.08 6.81 2.09 16.2 7.21 16.2 7.21 6.63-.7-.35.11 4.27-1.5.26-.52 13.9-3.99 17.77-15.19 6.26-18.1-8.72-29.62-21.22-29.62z";
    if (p == 3) return "M295 41.32s25.47 6.38 19.2 33.24c-4.39 18.83-.08 20.03 2.88 19.56 6.84-1.08 8.92-10.26 8.92-10.26s21.55 53.32-26.9 58.35c-6.38.66-12.83-.57-18.43-3.7-6.89-3.85-14.22-11.37-16-26.03-2.42-20.01 11.73-33.95 24.28-45.31C302.38 55.02 295 41.32 295 41.32z";
    if (p == 4) return "M275.33 158.87c7.14-2.24 6.98.98 9.84 1.81l7.84-24.31-13.28-4.94s-13.97 30.44-4.4 27.44z";
    if (p == 5) return "m286.44 108.95 4.08.72-70.57 178.69a4.64 4.64 0 0 0 2.62 6.02l12.37 4.87c1.01.4 2.15.24 3.02-.41l2.49-1.87a8.461 8.461 0 0 0 2.93-4.06l57.75-173.23";
    if (p == 6) return "M298.21 140.13c5-4.41 9.31-10.41 10.97-14.87 3.27-8.81-1.21-18.61-10.02-21.88-8.81-3.27-18.61 1.21-21.88 10.02-1.66 4.46-2.31 11.82-1.41 18.43.41 3.01.09 6.07-.97 8.91l-1.4 3.77c-.58 1.57-.63 3.32-.01 4.88.66 1.68 2.05 3.03 4.92 1.2 5.4-3.45 5.96 2.26 9.89 2.02 3.19-.2 4.82-5.09 4.82-5.09 1.06-2.85 2.82-5.38 5.09-7.39z";
    if (p == 7) return "M305.24 119.52c2.06-.57 3.04-2.54 2.23-4.44-1.53-3.59-4.78-6.75-9.15-8.37-4.33-1.61-8.82-1.37-12.31.32-1.93.93-2.48 3.12-1.23 4.95 1.75 2.56 5.02 5.01 9.16 6.55 4.17 1.54 8.3 1.82 11.3.99z";
    if (p == 8) return "M123.46 201.21s7.06 19.39 23.82 18.19c31.92-2.28 37.62 21.36 37.62 21.36s-18.18-17.28-49.38-9.12c-17.89 4.68-28.72-23.06-28.72-23.06";
    if (p == 9) return "M104.2 211.24s4.1 26.97 28.32 24.84c27.24-2.4 36.26 18.67 36.26 18.67s-11.66.23-33.44 5.18-24.42-8.01-34.8-16.16c-5.53-4.35-29.69-11.98-39.18 7.75 0 0 3.79-17.45 12.63-20.58 8.84-3.13 19.69-2.93 32.8 9.87s19.13 13.56 29.38 10.84c10.26-2.72 18.3-.51 18.3-.51s1.08-7.37-26.83-5.93c-17.09.88-18.95-18.39-30.74-20.9-11.79-2.5-14.31.98-14.31.98l21.61-14.05z";
    if (p == 10) return "M59.93 256.97s15.35-19.57 37.31-6.25c0 0-22.56-1.32-35.87 18";
    if (p == 11) return "M78.64 257.32s-5.87 18.82-17.27 15.59c0 0-1.2 3.31 3.11 11.41 0 0 15.36-3.96 14.16-27z";
    if (p == 12) return "M238.06 221.85s-5.82 11.6-29.76 9.98c0 0 14.53 13.16 30.7 2.95l-.94-12.93z";
    if (p == 13) return "M237.98 238.82s-12.74 10.1-29.51 0c0 0-6.53-4.2-6.5-12.05 0 0-3.15 11.27 4.83 19.15 0 0-11.38-1.69-14.15-10.75 0 0 1.88 24.46 39.92 18.74";
    if (p == 14) return "M181.84 248.68s16.02-2.85 22.2 8.76c11.78 22.12 25.47 6.64 25.47 6.64l-11.79 14.6s-9.57-1.57-15.86-13.93c-9.22-18.11-20.02-16.07-20.02-16.07z";
    if (p == 15) return "M209.45 257.4s6.32 10.56 17.08 7.82l5.54-6.14c-.01 0-11.7 4.63-22.62-1.68z";
    if (p == 16) return "M85.86 278.21c1.23 1.72 1.99 7.06 17.51 2.97";
    if (p == 17) return "M82.31 266.57c-.13 4.93 1.7 9.02 4.55 12.64";
    if (p == 18) return "M101.79 235.57c-3.87 3.41-7.43 7.09-10.52 11.05";
    if (p == 19) return "M84.57 257.39c-1.49 3.37-2.19 6.41-2.26 9.18";
    if (p == 20) return "M91.26 246.62c-3.07 3.94-5.25 7.51-6.69 10.76";
    if (p == 21) return "M145.13 210.05c-7.91 3.24-16.83 7.43-25.5 12.64";
    if (p == 22) return "M90.19 227.83c-.79.54-1.58 1.09-2.35 1.65-3.72 2.69-7.15 5.56-10.08 8.58-1.71 1.77-3.25 3.59-4.57 5.45-2.57 3.64-4.31 7.46-4.9 11.42";
    if (p == 23) return "M73.2 243.51c-2.57 3.64-4.31 7.46-4.9 11.42";
    if (p == 24) return "M118.32 212.65c-5.31 2.33-11.15 5.13-16.91 8.31-3.83 2.12-7.63 4.42-11.22 6.87";
    if (p == 25) return "M118.32 212.65c-5.31 2.33-11.15 5.13-16.91 8.31";
    if (p == 26) return "M90.19 227.83c-.79.54-1.58 1.09-2.35 1.65";
    if (p == 27) return "M70.53 281.51C72.32 285.61 77 290 76 293";
    if (p == 28) return "M66.5 265.5s.31 7.49 4.03 16.01";
    if (p == 29) return "M119.01 271.04c.7 2.73-1.75 8.44-1.53 11.13";
    if (p == 30) return "M106.93 242.06c-1.19 4.35-1.25 8.56-.73 12.68";
    if (p == 31) return "M123.23 220.6a46.15 46.15 0 0 0-7.51 6.52";
    if (p == 32) return "M108.5 265.19c.85 2.99 4.02 9.37 4.76 12.29";
    if (p == 33) return "M110.1 234.6c-1.47 2.53-2.5 5.01-3.17 7.46";
    if (p == 34) return "M134.63 214.76c-3.82 1.38-7.69 3.27-11.4 5.85";
    if (p == 35) return "M116.48 281.17c.29 3.65 1.99 7.25 2.02 11.33";
    if (p == 36) return "M106.2 254.74c.45 3.55 1.33 7.03 2.3 10.45";
    if (p == 37) return "M115.72 227.13c-2.36 2.54-4.2 5.03-5.63 7.47";
    if (p == 38) return "M208.05 260c1.32 4.31 3.52 7.91 6.16 11.1";
    if (p == 39) return "M210.36 233.15c-1.24 2.93-2.22 6.1-2.86 9.53";
    if (p == 40) return "M206.74 252c.11 2.93.57 5.57 1.31 7.99";
    if (p == 41) return "M221.44 216.37c-2.49 3.2-9.32 12.62-11.07 16.78";
    if (p == 42) return "M207.51 242.68c-.63 3.4-.86 6.5-.76 9.32";
    if (p == 43) return "M129.89 263.43c.36 1.17.81 2.54 1.28 4.09";
    if (p == 44) return "M135.08 231.59c-3.23 3.88-5.32 8.42-6.32 13.28";
    if (p == 45) return "M131.17 267.52c.48 1.57 1 3.32 1.5 5.22";
    if (p == 46) return "M143.73 224.47c-3.48 1.95-6.35 4.36-8.65 7.12";
    if (p == 47) return "M132.66 272.73c1.4 5.33 3.68 12.85 3.77 19.96";
    if (p == 48) return "M128.76 244.87c-1.22 5.94-.81 12.35 1.12 18.57";
    if (p == 49) return "M171.5 209.5c-8.91 4.01-24.32 13.04-27.77 14.97";
    if (p == 50) return "M160.47 293.66s-.57-3.95-1.06-5.43c-.81-2.45-3.45-3.43-4.65-6.43";
    if (p == 51) return "M178.99 252.87c.03 7.24 1.2 13.96 2.95 20.37";
    if (p == 52) return "M180.1 240.15c-.8 4.43-1.13 8.65-1.12 12.72";
    if (p == 53) return "M181.94 273.24c1.51 5.53 5.6 11.13 7.04 18.6";
    if (p == 54) return "M184.71 220.97c-1.71 4.68-3.84 14.9-4.61 19.18";
    if (p == 55) return "M216.07 269.69c4.93-6.17 8.51-13.7 10.74-21.97";
    if (p == 56) return "M203.5 280.54c4.88-2.78 9.07-6.47 12.57-10.85";
    if (p == 57) return "M226.81 247.72c2.72-10.11 3.51-24.58 2.19-35.72";
    if (p == 58) return "M188.54 285.8c5.95-.77 10.27-2.59 14.96-5.26";
    if (p == 59) return "M155.28 234.82c2.8-4.01 6.44-6.72 10.48-8.73";
    if (p == 60) return "M150.26 265.84c-.61-3.95-.86-8.03-.63-12.18";
    if (p == 61) return "M176.85 222.02c3.33-.96 13.27-3.79 13.27-9.37";
    if (p == 62) return "M151.42 242.91c.97-3.18 2.28-5.84 3.85-8.09";
    if (p == 63) return "M154.76 281.79c-2.01-4.98-3.63-10.34-4.5-15.95";
    if (p == 64) return "M165.76 226.09c3.49-1.74 7.28-2.97 11.09-4.07";
    if (p == 65) return "M149.63 253.66c.23-4.13.85-7.68 1.79-10.75";
    if (p == 66) return "m132.95 196.17-43.59 23.15c-10.2 5.42-18.71 13.62-24.24 23.75-6.63 12.14-10.2 28.89 2.61 46.83a9.47 9.47 0 0 0 7.71 3.96h113.95c2.97 0 5.93-.51 8.71-1.55 9.93-3.68 31.1-15.4 39.87-50.01 2.16-8.53.45-22.04 1.27-28.53.55-4.34 1.52-7.47 2.65-9.73";
    if (p == 67) return "M131.21 189.68c-3.31.73-4.45 6.48-2.65 9.55 7.67 13.09 38.13 20.17 38.13 20.17.93-2.67 12.94-3.69 10.16-4.2-13.68-2.55-42.06-20.74-45.64-25.52z";
    if (p == 68) return "M241.34 206.9c-7.2 4.18-15.13 7.33-23.43 9.33-3.22.78-4.56 4.62-2.55 7.25 0 0 19.09-2.21 26.34-8.3 2.54-2.15 2.79-6.83-.36-8.28z";
    if (p == 69) return "M241.91 205.55c2.16 3.41 1.26 9.67-2.26 11.66-9.48 5.37-24.25 6.61-24.25 6.61";
    if (p == 70) return "M80.68 293.8h24.12v-1.28c0-6.08-4.93-11.01-11.01-11.01";
    if (p == 71) return "M137.88 64.14c-18.79-4.37-23.88-7.52-25.52-9.37 2.19 3.93 8.45 16.18 10 28.61 1.86 14.9 24.22 34.77 24.22 34.77 5.08 4.2 28.43 7.22 25.43-10.11-2.01-11.58-14.31-39.29-34.13-43.9z";
    if (p == 72) return "M112.35 54.77c-.44-.78-.69-1.21-.69-1.21s0 .44.69 1.21z";
    if (p == 73) return "M164.44 109.72s-2.4-29.04-35.88-39.6c0 0-3.18 14.98 29.25 44.69 2.72-2.4 3.54-3.24 6.63-5.09";
    if (p == 74) return "M241.22 116.36c6.26-4.65 14.83-11.36 19.94-16.8 8.76-9.32-1.2-29.44-15.8-27.29-10.04 1.48-16.99 20.3-20.35 31.91 3.22 1.65 14.07 9.87 16.21 12.18z";
    if (p == 75) return "M257.29 88.45c2.22 13.17-26.25 27.87-26.25 27.87l7.68 5.28c11.31-3.51 27.6-24.53 27.6-24.53l-9.03-8.62z";
    if (p == 76) return "M234.93 113.35s24.59-11.73 22.37-24.9l9.03 8.62s-13.77 19.1-25.08 22.61";
    if (p == 77) return "m255.76 97.36-10.92 9.96s-13.8-15.12-1.08-31.08c0 0 12.07 20.62 12 21.12z";
    if (p == 78) return "M227.68 111.52c.67-19.51 16.11-35.28 16.11-35.28s4.71 16.82 15.47 22.87 14.8 14.13 14.8 14.13c2.02-8.07 4.71-42.38-20.18-47.08S220 109 220 109";
    if (p == 79) return "M126.04 67.48s7.24 26.18 30.24 45.84c1.42-1.34 6.05-3.33 6.24-3.6-12-7.2-36.48-42.24-36.48-42.24z";
    if (p == 80) return "M228.52 108.64c.67-19.51 15.27-32.4 15.27-32.4s4.71 16.82 15.47 22.87 14.8 14.13 14.8 14.13c2.02-8.07 4.71-42.38-20.18-47.08s-32.92 38.77-32.92 38.77";
    if (p == 81) return "M170.2 105.52s0-28.92-32.32-41.38c-25.58-9.86-26.22-10.58-26.22-10.58s6.58 14.64 10.66 29.88c5.86 21.91 28.8 36.72 28.8 36.72";
    if (p == 82) return "M124.84 67.24s9.37 29.11 31.36 46.07c.47.36 1.12.37 1.59.02l4.74-3.53c.37-.27.56-.72.53-1.17-2.42-28.67-38.22-41.39-38.22-41.39z";
    if (p == 83) return "M196.44 168.66c-6.81 0-12.41-2.25-13.15-6.14-.06.61-.09 1.22-.09 1.85 0 9.05 5.93 16.39 13.24 16.39s13.24-7.34 13.24-16.39c0-.63-.03-1.24-.09-1.85-.74 3.9-6.35 6.14-13.15 6.14z";
    if (p == 84) return "M196.44 173.31c4.19 0 7.64 1.5 8.05 3.56 3.16-2.73 5.19-7.01 5.19-11.84 0-.57-.03-1.13-.09-1.68-.74 3.54-6.35 5.59-13.15 5.59-6.81 0-12.41-2.04-13.15-5.59-.06.55-.09 1.11-.09 1.68 0 4.83 2.04 9.11 5.19 11.84.41-2.06 3.85-3.56 8.05-3.56z";
    if (p == 85) return "M196.44 168.97c-6.81 0-13.24-5.23-13.24-4.6 0 9.05 5.93 16.39 13.24 16.39s13.24-7.34 13.24-16.39c0-.63-6.44 4.6-13.24 4.6z";
    if (p == 86) return "M203.41 147.83a4.116 4.116 0 0 0-5.81 0l-1.16 1.16-1.16-1.16a4.116 4.116 0 0 0-5.81 0 4.098 4.098 0 0 0 0 5.81l1.16 1.16 5.81 5.81 5.81-5.81 1.16-1.16c1.61-1.6 1.61-4.2 0-5.81z";
    if (p == 87) return "M252.76 179.56c-1.46 0-2.64-1.18-2.64-2.64v-22.68c0-1.46 1.18-2.64 2.64-2.64 1.46 0 2.64 1.18 2.64 2.64v22.68c0 1.46-1.18 2.64-2.64 2.64z";
    if (p == 88) return "M233.9 119.9c-12.89 0-23.34 10.45-23.34 23.34s10.45 23.34 23.34 23.34 23.34-10.45 23.34-23.34-10.45-23.34-23.34-23.34z";
    if (p == 89) return "m218.02 138.54 14.46 21.2a16.74 16.74 0 0 0 4.84-.29l-17.26-25.3c-.88 1.34-1.58 2.82-2.04 4.39z";
    if (p == 90) return "m245.95 154.6-18.23-26.72a16.631 16.631 0 0 0-6.6 4.82l17.93 26.29c2.67-.88 5.03-2.4 6.9-4.39z";
    if (p == 91) return "M149.41 144.88c.46 1.65 1.35 3.18 2.59 4.52 3.09 3.35 8.32 5.56 14.25 5.56 8.31 0 15.25-4.33 16.84-10.08";
    if (p == 92) return "M159.79 155.38s-.72 3.67-7.17 5.88c0 0 3.97-2.49 5.08-6.72";
    if (p == 93) return "M156.58 154.4s-.87 4.07-8.6 6.51c0 0 4.75-2.75 6.09-7.44";
    if (p == 94) return "M153.54 151.93s0 5.44-9.04 7.47c0 0 6.6-2.77 6.91-8.3";
    if (p == 95) return "M151.1 149.15s0 6.97-11.98 6.77c0 0 8.7-1.45 9.68-8.17";
    if (p == 96) return "M213.24 120.54s6.96-6.45 13.7-6.93c3.07-.22 4.11-.06 4.81 1.53.44 1-1.18 2.44-3.21 2.28-4.05-.32-4.1-1.63-15.3 3.12z";
    if (p == 97) return "M210.88 95.09c-.28-.01-.55 0-.81.03-.62-3.13-3.57-5.29-6.78-4.87-1.3.17-2.45.73-3.35 1.56a6.12 6.12 0 0 0-6.73-4.61 6.12 6.12 0 0 0-5.33 6.41 6.123 6.123 0 0 0-7.5 6.73c.43 3.35 3.5 5.72 6.85 5.29.43 3.35 3.5 5.72 6.85 5.29 2.32-.3 4.17-1.86 4.94-3.9a6.115 6.115 0 0 0 5.77 2.52 6.122 6.122 0 0 0 5.26-5.13c.12.01.23.03.35.03 2.58.13 4.78-1.86 4.9-4.44a4.648 4.648 0 0 0-4.42-4.91z";
    if (p == 98) return "M210.88 95.09c-.28-.01-.55 0-.81.03-.62-3.13-3.57-5.29-6.78-4.87-1.3.17-2.45.73-3.35 1.56a6.12 6.12 0 0 0-6.73-4.61c-3 .39-5.21 2.89-5.33 5.81a6.05 6.05 0 0 1 3.41-1.61c2.19-.28 4.25.63 5.54 2.22a3.283 3.283 0 0 0 3.5 1.06c2.6-.81 7.19 1.52 7.81 4.65 2.64-.71 5.05 1.94 5.24 4.23 1.11-.8 1.86-2.09 1.93-3.56a4.663 4.663 0 0 0-4.43-4.91z";
    if (p == 99) return "M208.62 102.55c-.78-.81-2.1-.81-2.84.03a4.914 4.914 0 0 1-3.69 1.67c-1.88 0-3.51-1.05-4.34-2.6a4.919 4.919 0 0 1-4.33 2.61c-2.72 0-4.92-2.19-4.92-4.91-2.72 0-4.92-2.19-4.92-4.91 0-.1 0-.2.01-.3-2.18 1.16-3.53 3.59-3.19 6.18.43 3.35 3.5 5.72 6.85 5.29.43 3.35 3.5 5.72 6.85 5.29 2.32-.3 4.17-1.86 4.94-3.9a6.115 6.115 0 0 0 5.77 2.52 6.122 6.122 0 0 0 5.26-5.13c.12.01.23.03.35.03 0 .02-.9-.93-1.8-1.87z";
    if (p == 100) return "M210.88 95.09c-.28-.01-.55 0-.81.03-.62-3.13-3.57-5.29-6.78-4.87-.59.08-1.15.23-1.67.46-.9.39-1.94.07-2.47-.75a6.094 6.094 0 0 0-5.93-2.76 6.11 6.11 0 0 0-5.1 4.39c-.29 1.02-1.15 1.78-2.2 1.88-.2.02-.41.05-.62.09-2.99.58-5.12 3.31-4.94 6.35.17 2.97 2.4 5.26 5.15 5.7.99.16 1.82.84 2.23 1.76 1.08 2.39 3.63 3.91 6.36 3.55 1.54-.2 2.88-.96 3.83-2.05.67-.77 1.81-.92 2.66-.34 1.19.81 2.68 1.21 4.22 1.01a6.124 6.124 0 0 0 5.2-4.78.4.4 0 0 1 .41-.31s4.78-1.86 4.91-4.44c.12-2.6-1.87-4.79-4.45-4.92z";
    if (p == 101) return "M245.95 201.39c-12.71 8.92-30.26 15.25-49.64 15.25-29.65 0-55.01-14.82-65.33-31.06-.21-.33-5.52 4.26-3.55 9.56 5.75 15.52 33.72 29.89 68.64 29.89 17.04 0 33.66-1.7 44.83-8.97 8.85-5.75 5.05-14.67 5.05-14.67z";
    if (p == 102) return "M199.09 217.09s9.5-4.32 24.21-8.06c2.05-.52 4.11.87 3.95 2.65-.27 3.04-1.22 6.58-6.36 12.85 2.76 2.96 4.45 6.51 4.86 10.22l.02.2c.29 1.7-1.47 3.14-3.51 2.85-4.93-.7-14.03-3.85-22.29-9.96";
    if (p == 103) return "M211.47 220.24s-6.21-.18-9.81 2.3c-1 .69-.76 1.96.44 2.44 3.39 1.37 10.17 2.38 13.87 2.78";
    if (p == 104) return "M186.98 216.63s-8.45-4.84-22.78-9.72c-2-.68-4.17.54-4.17 2.34.01 3.05.65 6.44 5.22 13.1-3.01 2.73-5 6.14-5.74 9.81l-.04.2c-.44 1.68 1.19 3.25 3.25 3.12 4.98-.31 14.32-2.74 23.08-8.17";
    if (p == 105) return "M174.93 219.52s6.3-.4 9.67 2.35c.94.77.59 2.01-.66 2.4-3.5 1.1-10.34 1.57-14.06 1.69";
    if (p == 106) return "m195.87 229.93-6.47-.25c-2.65-.1-4.7-2.2-4.6-4.68l.32-7.25c.07-1.66 1.56-2.94 3.33-2.87l9.66.38c1.77.07 3.14 1.47 3.07 3.12l-.32 7.25c-.11 2.47-2.35 4.4-4.99 4.3z";
    if (p == 107) return "m91.47 115.65 37.09 71.47c10.56 15.64 38.48 29.15 67.76 29.15 17.08 0 32.73-4.8 44.91-11.91 10.67-6.23 19.06-15.71 24.11-26.99l27.62-61.77c-34.71-5.65-61.89-13.82-96.96-13.82S126.18 110 91.47 115.65z";
    if (p == 108) return "M91.71 115.65h-.24l35.6 71.09c10.56 15.64 39.97 29.9 69.25 29.9 22.05 0 42.75-8.83 55.9-19.87 5.74-4.82 9.8-10.91 13.3-17.77l27.92-63.39c-117.28-20.53-108.36-16.59-201.73.04z";
    if (p == 109) return "m112.44 113.67 49.96 96.07";
    if (p == 110) return "M130.39 139.06c-.96-1.81-.32-4.09 1.41-5.09 1.74-1 3.91-.34 4.87 1.48.95 1.81.32 4.09-1.41 5.09-.55.32-1.14.47-1.73.47-1.26-.01-2.48-.71-3.14-1.95zm-6.54-12.42c-.96-1.81-.32-4.09 1.41-5.09 1.74-1 3.91-.34 4.87 1.47.95 1.81.32 4.09-1.41 5.09-.55.32-1.14.47-1.73.47-1.26 0-2.49-.7-3.14-1.94z";
    if (p == 111) return "M60.54 184.2c6.3 8.18 19.6 8.78 27.39 1.99 9.73-8.48 12.77-19.76 4.9-29.99-9.84-12.78-24.98-15.86-38.26-4.18-15.15 13.32-15.75 63.05 19.13 76.15l-10.17 21.36c-40.47-23.66-40.68-85.32-15.81-106.27 16.88-14.22 40.56-10.95 52.58 4.51 11.36 14.61 7.67 31.27-4.44 41.2-9.69 7.95-26.27 6.43-34.22-3.27";
    if (p == 112) return "M88.25 185.9c-.11.1-.22.19-.33.29-7.78 6.79-21.09 6.19-27.39-1.99l1.1 1.5c3.95 4.82 10.04 7.62 16.35 8.24 2.13-.78 4.13-1.92 5.86-3.42 1.68-1.47 3.15-3.02 4.41-4.62z";
    if (p == 113) return "M51.49 155.48c-.34.28-.67.56-1.01.85-15.15 13.32-15.75 63.05 19.13 76.15l-7.66 16.09c.52.32 1.04.64 1.57.95l10.17-21.36c-32.33-12.14-34.18-55.77-22.2-72.68z";
    if (p == 114) return "M100.29 147.76c-12.02-15.46-35.7-18.72-52.58-4.51a37.82 37.82 0 0 0-4.91 5.04c.27-.25.55-.49.83-.72 16.88-14.22 40.56-10.95 52.58 4.51 9.57 12.3 8.46 26.05.64 36.02 11.31-10.01 14.49-26.14 3.44-40.34z";
    if (p == 115) return "M49.54 141.81c-.62.46-1.23.94-1.83 1.45-24.87 20.95-24.66 82.6 15.81 106.27l3.1-6.52c-35.02-23.84-36.91-77.34-17.08-101.2z";
    if (p == 116) return "M63.52 249.52c-40.47-23.66-41.88-84-15.81-106.27 16.78-14.33 40.56-10.95 52.58 4.51 11.36 14.61 7.67 31.27-4.44 41.2-9.69 7.95-26.27 6.43-34.22-3.27-6.36-7.75-5.22-19.19 2.53-25.55 6.2-5.09 15.35-4.18 20.44 2.02";
    if (p == 117) return "M74.77 228.52c-34.88-13.1-38.61-60.48-20.21-76.51 13.34-11.62 28.42-8.6 38.26 4.18 7.87 10.23 4.83 21.51-4.9 29.99-7.78 6.79-21.09 6.19-27.39-1.99";
    if (p == 118) return "m331.29 118.59-4.43-56.83c-.8-3.96-2.65-7.62-5.33-10.58-2.52-2.78-5.74-4.9-9.31-6.13a22.428 22.428 0 0 0-10.98-.93c-3.91.66-7.58 2.38-10.64 4.98-3.49 2.98-5.98 6.94-7.18 11.47-.01.04-.02.08-.03.13l-56.37 219.83c-1.78 7.35 5.39 15.7 12.74 17.46l6.84 1.64 57.34-233.66c.12-.43.3-.62.42-.73.14-.12.4-.34.94-.15.65.23.75.72.78.88l5.74 55.79";
    if (p == 119) return "m329.07 87.82-1.75-16.75s-7.47-6.65-20.4-.81l2.8 17.22c12.61-7.1 19.35.34 19.35.34z";
    if (p == 120) return "m306.22 67.31 7.66-19.97s-15.85-9.46-28.53 8.36l17.78 13.51c3.31-1.29 3.09-1.9 3.09-1.9z";
    if (p == 121) return "M326.03 62.18a4.848 4.848 0 0 0-4.22 5.62l4.23 51.41-14.16 2.56.07.48 19.25-3.4-5.17-56.67z";
    if (p == 122) return "m237.21 243.82-5.58 17.58s7.78 10.66 19.24 12.07l5-17.88c-11.47-1.42-18.66-11.77-18.66-11.77z";
    if (p == 123) return "m247.7 201.5-4.43 18.18s6.62 10.06 18.08 11.47l5.58-17.58c-11.45-1.41-19.23-12.07-19.23-12.07z";
    if (p == 124) return "m259.79 159.74-4.33 18.39s6.52 9.84 17.99 11.25l5.58-17.58c-11.46-1.4-19.24-12.06-19.24-12.06z";
    if (p == 125) return "m267.9 119.98-4.11 17.03s7.29 10.75 18.75 12.16l3.68-18.39c-11.46-1.41-18.32-10.8-18.32-10.8z";
    if (p == 126) return "M278.97 78.16 274.2 96.8s6.97 9.47 18.44 10.88l3.8-17.88c-11.47-1.41-17.47-11.64-17.47-11.64z";
    if (p == 127) return "M296.21 70.95 241.02 298.3l5.57 1.34 58.24-236.11-2.65.91a9.228 9.228 0 0 0-5.97 6.51z";
    if (p == 128) return "m331.33 117.43-1.11-15.2s-8.62-5.38-20.08 1.98l1.77 15.73c11.46-7.36 19.42-2.51 19.42-2.51z";
    if (p == 129) return "m304.83 63.53 6.88 57.06 6.35-.97-4.86-48.67a8.882 8.882 0 0 0-8.37-7.42z";
    if (p == 130) return "M322.91 125.12c-5.65.9-10.55-.39-10.94-2.88-.39-2.49 3.87-5.23 9.52-6.12 5.65-.9 9.35.39 9.74 2.88.39 2.48-2.67 5.22-8.32 6.12z";
    if (p == 131) return "M322.91 125.12c-6.08.96-11.33-.27-11.72-2.75-.39-2.49 4.22-5.28 10.31-6.25 6.08-.96 10.13.27 10.52 2.75.39 2.49-3.02 5.28-9.11 6.25z";
    if (p == 132) return "M327.69 98.79c4.88-14.9 3.76-28.58.09-43.88-.37-1.56-2.39-1.98-3.34-.69l-9.09 12.26 1.41-19.7c.08-1.18-1.44-1.73-2.12-.76l-11.82 16.75.37-20.49c.02-1.19-1.53-1.65-2.16-.64l-10.53 16.7.17-15.44c.02-1.61-1.86-2.49-3.09-1.45-12.11 10.15-21.22 20.64-26.14 35.65-5.69 17.37-3.77 34.74 3.79 45.97 4.24 6.3 5.59 14.1 3.23 21.31l-28 85.55 16.56 5.42 28.68-87.63c2.22-6.79 7.39-12.1 13.93-14.96 11.89-5.21 22.7-17.6 28.06-33.97z";
    if (p == 133) return "M326.85 53.07c-.37-1.56-1.46-.15-2.41 1.14l-.51.69c3.28 15.23 3.43 26.22-1.3 40.7-5.36 16.38-16.17 28.77-28.06 33.97-6.55 2.86-11.71 8.17-13.93 14.96l-28.68 87.63 4.14 1.36 28.68-87.63c2.22-6.79 7.39-12.1 13.93-14.96 11.89-5.2 22.7-17.59 28.06-33.97 4.87-14.91 3.75-28.58.08-43.89z";
    if (p == 134) return "M270.74 124.87c-7.56-11.22-9.47-28.6-3.79-45.97 4.58-14 12.45-22.97 23.68-33.47l.03-2.54c.02-1.61-1.86-2.49-3.09-1.45-12.11 10.15-21.22 20.64-26.14 35.65-5.69 17.37-3.77 34.74 3.79 45.97 4.24 6.3 5.59 14.1 3.23 21.31l-28 85.55 5.52 1.81 28-85.55c2.37-7.21 1.02-15.01-3.23-21.31z";
    if (p == 135) return "M319.41 86.1c-.21.94-.43 1.89-.69 2.84-6.05 22.05-24.26 36.27-40.68 31.76-1.12-.31-2.19-.7-3.24-1.16 2.6 2.81 5.79 4.87 9.47 5.88 13.54 3.71 28.55-8.01 33.54-26.19 1.23-4.47 1.74-8.92 1.6-13.13z";
    if (p == 136) return "M327.69 98.79c4.88-14.9 3.76-28.58.09-43.88-.37-1.56-2.39-1.98-3.34-.69l-7.85 11.22c-.46.66-1.51.28-1.43-.52l1.6-18.14c.08-1.18-1.44-1.73-2.12-.76L303.9 61.86c-.45.66-1.47.32-1.44-.47l.72-19.12c.02-1.19-1.53-1.65-2.16-.64l-9.39 15.5c-.42.7-1.5.38-1.47-.44l.51-13.78c.02-1.61-1.86-2.49-3.09-1.45-12.11 10.15-21.22 20.64-26.14 35.65-5.69 17.37-3.77 34.74 3.79 45.97 4.24 6.3 5.59 14.1 3.23 21.31l-28 85.55 16.56 5.42 28.68-87.63c2.22-6.79 7.39-12.1 13.93-14.96 11.89-5.22 22.7-17.61 28.06-33.98z";
    if (p == 137) return "m236.69 297.8-17.91-5.86c-2.82-.92-4.36-3.96-3.44-6.79l35.03-107.03c.92-2.82 3.96-4.36 6.79-3.44l17.91 5.86c2.82.92 4.36 3.96 3.44 6.79l-35.03 107.03a5.394 5.394 0 0 1-6.79 3.44z";
    if (p == 138) return "m134.72 243.74 3.01-2.8c2.15-2 5.2-2.71 8.01-1.85l15.57 4.77c1.83.56 3.4 1.74 4.45 3.33 2.77 4.2 1.16 9.88-3.41 12l-5.96 2.75a17.349 17.349 0 0 1-20.95-5.08l-1.6-2.05a8.219 8.219 0 0 1 .88-11.07z";
    if (p == 139) return "m132 225.54.12-2.41a4.822 4.822 0 0 1 2.63-4.05l8.52-4.35c1-.51 2.14-.66 3.24-.41 2.89.64 4.53 3.7 3.46 6.46l-1.39 3.6a10.198 10.198 0 0 1-10.92 6.42l-1.51-.21a4.86 4.86 0 0 1-4.15-5.05z";
    if (p == 140) return "m63.52 249.52 5.03-1.36c1.2-.33 2.48-.29 3.64.16.08.03 2.75 1.86 3.34 3.28.47 1.14 1.15 2.9 1.65 4.69.81 2.91-.06 6.03-2.23 8.13l-4.3 4.17c-1.08 1.39-4.59 2.58-4.59 2.58-3.86.56-7.03.04-7.38-3.84-.33-3.8 2.4-17.77 4.84-17.81z";
    if (p == 141) return "M87.14 249.81c-.55 2.46-3.67 4.83-6.13 4.28-2.46-.55-3.21-3.8-2.66-6.25s2.19-3.2 4.65-2.65 4.69 2.17 4.14 4.62z";
    if (p == 142) return "M128.77 216.4c1.25.71 2.04 2.81 1.33 4.06-.71 1.25-2.61 1.13-3.86.42s-1.39-1.73-.68-2.99c.7-1.25 1.95-2.2 3.21-1.49z";
    if (p == 143) return "m122 203.97 1.48 5.47a7.464 7.464 0 0 0 9.5 4.21l8.19-3.72-8.4-12.96-10.77 7z";
    return "";
  }
}