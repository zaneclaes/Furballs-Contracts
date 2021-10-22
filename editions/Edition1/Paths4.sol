// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPaths.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1Paths4 is IFurballPaths {
  function path(uint8 p) external pure override returns(bytes memory) {
    if (p == 0) return "M257.47 109.26a11.003 11.003 0 0 0-8.22-3.66c-6.1 0-12.04 4.16-11.05 13.47";
    if (p == 1) return "M147.55 131.16s-13.77-17.66-23.15-2.66c-9.83 15.72 14.12 26.09 14.12 26.09";
    if (p == 2) return "M144.99 129.2s-11.21-15.7-20.59-.7c-9.83 15.72 10.77 23.67 10.77 23.67";
    if (p == 3) return "M139.36 141.97c5.64-5.37-5.64-11.38-5.64-11.38s-4.82.72-4.99 4.95c-.14 3.43 5.69 11.13 10.63 6.43z";
    if (p == 4) return "M130.1 131.52s8.42-5.76 10.1 9.15";
    if (p == 5) return "M245.27 131.16s13.77-17.66 23.15-2.66c9.83 15.72-14.12 26.09-14.12 26.09";
    if (p == 6) return "M247.83 129.54s11.21-16.05 20.59-1.04c9.83 15.72-10.77 23.67-10.77 23.67";
    if (p == 7) return "M253.46 141.97c-5.64-5.37 5.46-11.38 5.46-11.38s5.01.72 5.17 4.95c.14 3.43-5.69 11.13-10.63 6.43z";
    if (p == 8) return "M262.72 131.52s-8.42-5.76-10.1 9.15";
    if (p == 9) return "M170.98 128.04c-.04 0-.07-.01-.11-.01-3.47 0-6.28 2.81-6.28 6.28s2.81 6.28 6.28 6.28c2.3 0 4.31-1.24 5.4-3.09a23.34 23.34 0 0 0-5.29-9.46z";
    if (p == 10) return "m217.25 119.79 18.42 1.19-17.81 4.85a3.078 3.078 0 1 1-.61-6.04z";
    if (p == 11) return "M250.87 131.17c-12.17-3.56-25.31-3.56-37.48 0h-.01c-2.89 3.44-4.59 7.71-4.59 12.33 0 4.37 1.53 8.41 4.13 11.75l18.25-3.29 20.17 3.29c2.6-3.34 4.13-7.39 4.13-11.75-.01-4.62-1.72-8.89-4.6-12.33z";
    if (p == 12) return "M232.13 127.44c-8.73 0-15.81 7.08-15.81 15.81 0 3.94 1.44 7.54 3.82 10.3l24.09-.11c2.32-2.75 3.73-6.31 3.73-10.2-.01-8.72-7.09-15.8-15.83-15.8z";
    if (p == 13) return "M251.33 155.25c2.6-3.34 4.13-7.39 4.13-11.75 0-4.62-1.71-8.89-4.59-12.33-12.17-3.56-25.31-3.56-37.48 0h-.01c-2.89 3.44-4.59 7.71-4.59 12.33 0 4.37 1.53 8.41 4.13 11.75";
    if (p == 14) return "M211.96 157.46c3.96-3.27 11.62-5.48 20.41-5.48s16.45 2.21 20.41 5.48";
    if (p == 15) return "M161.46 159.07h.02c-.01-.01-.01-.01-.02 0 0-.01 0-.01 0 0z";
    if (p == 16) return "M153.94 157.23s0 .01.01.01h.01c-.01 0-.02 0-.02-.01z";
    if (p == 17) return "M153.4 148.03a4.713 4.713 0 0 1-4.71 4.62h-.08c1.4 1.9 3.22 3.47 5.32 4.59.01 0 .01.01.02.01a4.7 4.7 0 0 0 3.35-3.43c.24-.98-3.75-5.77-3.9-5.79z";
    if (p == 18) return "M150.7 145.07c-1.19 0-4.29.29-5.12-.44a15.69 15.69 0 0 0 2.51 7.26c.17.26.34.51.52.75h.08c2.57 0 4.66-2.06 4.71-4.62 0-.02-1.45-2.95-2.7-2.95z";
    if (p == 19) return "M150.94 139.56c-1.49 0-3.63-.57-4.49-1.65-.6 1.67-.93 3.47-.93 5.34 0 .39.05 1.31.06 1.38.83.73 1.92 1.06 3.11 1.17 4.41.43 3.25-6.24 2.25-6.24z";
    if (p == 20) return "M150.19 132.04a15.849 15.849 0 0 0-3.74 5.88c.86 1.08 2.74 1.89 4.23 1.89 1 0 3.85-2.72 4.08-3.96a4.714 4.714 0 0 1-4.57-3.81z";
    if (p == 21) return "M157.91 127.81a15.836 15.836 0 0 0-7.73 4.22c.42 2.16 2.3 3.79 4.57 3.81.02 0 3.63-1.15 4.36-2.8a4.722 4.722 0 0 1-1.2-5.23z";
    if (p == 22) return "M166.69 128.37c-1.67-.6-3.47-.93-5.35-.93-1.11 0-3.36.36-3.42.37-1.36 2.4.71 5.28.86 5.35 7.6 3.36 7.68-4.59 7.91-4.79z";
    if (p == 23) return "M166.86 128.43c-.01-.06-.03-.12-.05-.18-.04.04-.09.07-.13.11.06.03.12.05.18.07z";
    if (p == 24) return "M177.02 141.4c-.15-1.06-.42-2.09-.81-3.08-6.13.52-4.93 6.01-4.33 7.16 1.3-.41 3.03-1.05 4.41-.57.25.09.49.19.72.3.1-.64.14-1.3.14-1.96 0-.62-.05-1.24-.13-1.85z";
    if (p == 25) return "M176.43 144.91a4.66 4.66 0 0 0-3.48-.06c-1.17.44-3.1 4.13-3.02 4.89.91-.2 1.89-.13 2.81.26.84.35 1.53.92 2.02 1.62.77-1.23 1.38-2.58 1.79-4.01.22-.77.38-1.57.49-2.39-.2-.12-.4-.22-.61-.31z";
    if (p == 26) return "M172.73 150c-2.7-1.25-5.06.7-5.75 1.75 1.95.84 3.05 2.85 2.81 4.87 1.26-.8 2.4-1.77 3.38-2.88.59-.66 1.12-1.37 1.59-2.12-.5-.7-1.2-1.24-2.03-1.62z";
    if (p == 27) return "M161.98 152.56c-.62-.76-4.43.28-4.67 1.25a4.7 4.7 0 0 1-3.35 3.43c2.2 1.16 4.71 1.83 7.38 1.83h.12l.01-.01c.69-.61 1.2-1.43 1.44-2.4.36-1.49-.03-2.99-.93-4.1z";
    if (p == 28) return "M166.98 151.75c-.02-.01-.03-.01-.05-.02a4.702 4.702 0 0 0-4.96.83c.9 1.11 1.3 2.61.93 4.1a4.76 4.76 0 0 1-1.44 2.4s0 .01.01.01a15.779 15.779 0 0 0 8.32-2.45c.24-2.02-.86-4.03-2.81-4.87z";
    if (p == 29) return "M171.12 126.73c-.04 0-.08-.01-.12-.01-3.95 0-7.16 3.21-7.16 7.16s3.21 7.16 7.16 7.16c2.62 0 4.91-1.42 6.16-3.52a26.467 26.467 0 0 0-6.04-10.79z";
    if (p == 30) return "M226.67 144.9a6.24 6.24 0 0 1-5.59 3.46c-1.59 0-4.38-1.94-4.42-1.84.6 2.43 1.9 5.2 3.48 7.03 0 0 8.62-2.49 8.62-4 0-1.84-.81-3.51-2.09-4.65z";
    if (p == 31) return "M227.19 140.83a6.23 6.23 0 0 1-3.47 1.05c-2.99 0-5.49-2.11-6.1-4.92a15.73 15.73 0 0 0-1.3 6.29c0 1.12.12 2.21.34 3.27.09.09.18.18.27.26 1.1.98 2.55 1.58 4.15 1.58a6.25 6.25 0 0 0 5.59-3.46c.42-.84.65-1.78.65-2.78 0-.44-.05-.87-.13-1.29z";
    if (p == 32) return "M217.64 136.91c-.01.01-.02.01-.03.02 0 .01.01.02.01.03.01-.01.02-.03.02-.05z";
    if (p == 33) return "M225.88 133.24c0-1.12 3.26-3.51-1.45-3.8-3 1.68-5.4 4.3-6.79 7.47-.01.02-.01.03-.02.05.61 2.81 3.11 4.92 6.1 4.92 1.28 0 2.47-.39 3.47-1.05.8-.54 1.48-1.26 1.96-2.1a6.241 6.241 0 0 1-3.27-5.49z";
    if (p == 34) return "M235.09 138.73c.52.86 2.52 2.34 2.68 2.42.12-.74.37-1.47.77-2.15 1.61-2.75 5-3.81 7.86-2.58a15.843 15.843 0 0 0-6.78-7.1c-.75.1-1.48.33-2.15.7.56.94-.43 7.65-2.38 8.71z";
    if (p == 35) return "M246.55 136.74c.02-.08.03-.15.04-.23-.06-.03-.13-.06-.19-.09.05.11.1.21.15.32z";
    if (p == 36) return "M246.55 136.74c-.05-.11-.1-.21-.15-.32a6.233 6.233 0 0 0-7.86 2.58c-.4.68-.8 4.58-.32 5.68a6.19 6.19 0 0 1 3.73-1.24c2.44 0 4.54 1.4 5.57 3.43.27-1.16.42-2.37.42-3.62.01-2.32-.49-4.53-1.39-6.51z";
    if (p == 37) return "M237.46 130.01c-.59-.98-10.17-.9-10.77.14a6.252 6.252 0 0 0 2.44 8.58c.88.48 5.06.48 5.94 0a6.241 6.241 0 0 0 3.27-5.49 6.05 6.05 0 0 0-.88-3.23z";
    if (p == 38) return "M247.42 147.32c.08-.06.16-.11.25-.17-.04-.09-.09-.19-.13-.28l-.12.45z";
    if (p == 39) return "M241.96 143.44c-1.4 0-2.69.46-3.73 1.24-1.52 1.14-4.87 6.11-1.21 8.8l7.21-.03c1.48-1.76 3.27-6.43 3.31-6.58-1.04-2.03-3.14-3.43-5.58-3.43z";
    if (p == 40) return "M156.49 130.6h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.44-1.65-1.26-3.14-2.36-4.37z";
    if (p == 41) return "M179.9 131.09h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.44-1.65-1.26-3.14-2.36-4.37z";
    if (p == 42) return "M167.85 148.75h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.45-1.65-1.27-3.14-2.36-4.37z";
    if (p == 43) return "M226.81 130.6h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.44-1.65-1.26-3.14-2.36-4.37z";
    if (p == 44) return "M250.22 131.09h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.44-1.65-1.26-3.14-2.36-4.37z";
    if (p == 45) return "M238.17 148.75h-.05c-1.55 0-2.81 1.3-2.81 2.9 0 1.6 1.26 2.9 2.81 2.9 1.03 0 1.92-.57 2.41-1.43-.45-1.65-1.27-3.14-2.36-4.37z";
    if (p == 46) return "M196.38 152.08h-.12c-9.48.09-25.31 11.33-25.11 20.52.37 16.72 48.84 13.05 50.34 0 1.05-9.13-15.63-20.42-25.11-20.52z";
    if (p == 47) return "M196.66 152.32h-.08c-6.19.05-16.41 5.56-16.41 10.07 0 4.17 3.78 6.34 16.86-.08.93-.45-1.05-.05 0 0 6.39.32 17.84 10.63 17.84-.49.01-3.27-12.02-9.45-18.21-9.5z";
    if (p == 48) return "M196.65 152.32h-.04c-10.86.21-9.5 3.07-8.71 5.35 2 5.73 4.18.58 7.53-.01 4.77-.84 7.03 5.87 9.93.01 2.34-4.72-5.42-5.32-8.71-5.35z";
    if (p == 49) return "M196.38 152.08h-.12c-7.7.08-19.47 7.51-23.61 15.22-.96 1.78-1.38 3.94-1.51 5.66-1.03 13.62 49.3 14.56 50.34 0 .67-9.17-15.62-20.78-25.1-20.88z";
    if (p == 50) return "M196.5 167.65c.82-2.1-.33-5.21-.33-5.21";
    if (p == 51) return "M192.28 158.85c0 1.27-1.38 2.16-2.7 1.74l-.04-.01c-1.73-.55-2.61-2.31-1.93-3.86l1.17-2.17";
    if (p == 52) return "M200.45 158.89c0 1.27 1.38 2.16 2.7 1.74l.04-.01c1.73-.55 2.61-2.31 1.93-3.86l-1.17-2.17";
    if (p == 53) return "M218.85 165.59s2.26 5.78-3.68 8.91c-5.94 3.13-14.96-6.96-18.58-6.8";
    if (p == 54) return "M173.08 169.72c.73 1.35 1.21 3.94 5.04 5.4 6.33 2.4 14.42-7.47 18.19-7.43";
    if (p == 55) return "M177.16 173.84s-9.46-10.32-.41-14.13c6.41-2.7 5.09 11.18 12.23 11.33 0 0-8.08 7.82-11.82 2.8z";
    if (p == 56) return "M212.23 171.27c0 7.29-7.31 6.66-16.07 6.66-8.87 0-16.07.62-16.07-6.66s7.19-13.19 16.07-13.19c8.88 0 16.07 5.91 16.07 13.19z";
    if (p == 57) return "M185.71 175.15c0-3.94 4.68-7.14 10.45-7.14s10.45 3.2 10.45 7.14";
    if (p == 58) return "M192.26 177.72s5.34 1.91 5.34 7.8v4.08c0 2.25 1.83 4.08 4.08 4.08s4.08-1.83 4.08-4.08v-4.4c0-1.93.57-3.81 1.65-5.41l1.31-2.07";
    if (p == 59) return "M204.71 147.59c0 4.55-3.69 3.38-8.23 3.38-4.55 0-8.23 1.17-8.23-3.38a8.23 8.23 0 0 1 16.46 0z";
    if (p == 60) return "M178.24 159.04c1.4-4.07 7.2 4.56 17.76 4.56 10.71 0 16.92-8.4 17.96-4.33 1.11 4.35-7.13 14.29-17.84 14.29s-19.34-10.25-17.88-14.52z";
    if (p == 61) return "M212.68 159.73s3.79 13.08-3.92 22.01c0 0-2.77-14.21-6.16-17.26l10.08-4.75z";
    if (p == 62) return "M179.4 159.73s-3.79 13.08 3.92 22.01c0 0 2.77-14.21 6.16-17.26l-10.08-4.75z";
    if (p == 63) return "M207.07 90.46 196.26 48.4l-10.8 42.02c-.15.63.09 1.28.61 1.68 2.72 2.05 21.14-1.05 21-1.64z";
    if (p == 64) return "M187.71 80.14c1.41 3.8 3.89 6.29 6.84 6.87 0 0 6.65.69 7.17 6.3";
    if (p == 65) return "M193.01 62.94c1 1.92 2.36 3.14 3.94 3.5 0 0 4.76.51 5.42 6.13";
    if (p == 66) return "M190.2 70.44c1.46 3.86 3.82 6.48 6.76 7.4 0 0 8.01 1.77 8.87 10.04";
    if (p == 67) return "m207.07 90.46-9.82-40.12c-.27-1.1-1.71-1.1-1.98 0l-9.81 40.08c-.15.63 13.59 13.49 22.54 5.98.48-.4-.79-5.35-.93-5.94z";
    if (p == 68) return "M223.15 87.32c-.01-.13-.03-.25-.05-.38 0 0-1.52 11.83-21.78 5.5-24.89-7.78-24.16 10.2-24.16 10.2 12.24-3.96 19.58 1.91 22.59 3.82 4.34 2.76 8.22 3.23 10.94 2.76 13.85-2.42 12.46-21.9 12.46-21.9z";
    if (p == 69) return "M131.92 187s-7.74 2.22-6.96 13.32c3.48 49.32 65.28 45.6 65.28 45.6s18.27-7.04 1.07-32.38c-10.43-15.38-30.23 3.1-59.39-26.54z";
    if (p == 70) return "M153.47 209.04c-10.47-2.04-18.29-15.01-18.15-14.63.85 2.34 7.21 11.79 9.23 13.86 2.59 2.66 6.33 9.64 6.33 9.4.1-3.17-.85-5.93-2.59-8.4 1.8 1.56 3.17 3.46 4.2 5.77 1.06 2.37 1.1 5.29 1.93 7.77.11.33.6-6.5-.79-9.52-.31-.68-.71-1.32-1.17-1.94 1.73 1.06 5.04 6.35 4.97 6.04-.65-2.82-2.25-5.16-4.35-6.97 1.8.83 5.29 3.32 5.19 3.16-1.3-2.06-2.44-4.08-4.8-4.54z";
    if (p == 71) return "M141.49 197.49c-.23-.35-.5-.28-.28.09 2.58 4.42 7.51 9.12 12.71 9.73.45.05-9.4-5.24-12.43-9.82z";
    if (p == 72) return "M131.15 187.02c.62 4.6-.17 10.9 2.63 14.6 1.29 1.71 5.76 6.1 7.27 7.59 2.09 2.07 2.68 4.2 2.95 7.08.05.51 2.8-3.76-6.94-13.81-3.91-4.02-5.99-16-5.91-15.46z";
    if (p == 73) return "M158.02 219.76c2.09 2.82 4.78 4.99 7.35 7.33 2.88 2.63 4.45 6.2 6.83 9.22.22.28-1.94-6.65-4.13-9.19-2.71-3.14-10.35-7.76-10.05-7.36z";
    if (p == 74) return "M158.74 214.9c-.41-.32 6.72 7.67 10.49 11.08 1.94 1.76 3.56 3.73 5.04 5.91 1.29 1.89 2.42 3.98 4.1 5.53.4.37-1.89-4.81-3.06-7.01-1.1-2.08-2.26-4.09-3.92-5.75-3.77-3.81-8.44-6.53-12.65-9.76z";
    if (p == 75) return "M165.7 216.38c2.04 1.46 4.02 2.83 5.73 4.71 1.8 1.98 3.18 4.37 4.42 6.75 1.22 2.33 5.45 9.59 10.54 12.4.47.26-4.21-6.04-5.36-8.66-6.03-13.76-15.73-15.49-15.33-15.2z";
    if (p == 76) return "M158.24 208.32c6.76.68 12.04 3.75 14.76 7.68.33.48-15.15-7.72-14.76-7.68z";
    if (p == 77) return "M166.02 205.38c6.72 2.27 12.16 4.74 15.01 11.86.24.58-15.29-11.96-15.01-11.86z";
    if (p == 78) return "M176.01 217.6c3.11 4.43 5.45 10.81 8.99 12.4 4.69 2.1-9.42-13.01-8.99-12.4z";
    if (p == 79) return "M187.6 218.8c-.42-.41-.97.18-.6.63 2.11 2.6 4.04 5.21 5.86 8.04.25.38.85.19.72-.25-.97-3.46-3.49-5.99-5.98-8.42z";
    if (p == 80) return "M189.29 245.96c-.88-3.99-2.96-8.8-6.85-14.54-10.08-14.85-28.89 1.88-56.44-23.67 8.16 38.29 55.93 38.42 63.29 38.21z";
    if (p == 81) return "M226.15 206.19c-10.37.25-31.96-2.77-40.05 17.58-11.39 28.64 22.16 32.7 22.16 32.7s-1.38-11.61 21.2-19.17c22.3-7.47 36.23-14.58 23.19-41.17-.01-.01-7.09 9.59-26.5 10.06z";
    if (p == 82) return "M229.45 237.29c14.88-4.98 26.13-10.3 27.05-21.61 0 0-16.59 11.48-26.52 10.86-10.45-.65-29.39 6.09-36.41 24.64 6.77 4.4 14.68 5.29 14.68 5.29s-1.38-11.62 21.2-19.18z";
    if (p == 83) return "M231.13 208.73c7.06-.95 14.56-8.88 14.39-8.59-1.02 1.75-7.53 8.43-9.47 9.81-2.49 1.77-4.84 3.98-6.14 6.78-.1.21 1.16-4.77 2.93-6.5-4.12 1.79-7.31 10.04-7.25 9.78 1.33-6.05 3.08-8.27 3.54-8.69-.27.15-3.59 2.83-4.56 4.34-.14.22 2.21-4.01 4.18-5.16-1.59.42-3.13.98-4.52 2.04-.14.1.81-3.1 6.9-3.81z";
    if (p == 84) return "M239.61 209.68c-2.79 1.25-4.07 5.6-4.12 5.26-.62-4.39 5.31-7.45 7.49-9.07 3.36-2.5 2.92-2.43 4.62-6.27.17-.37 1.8 5.7-7.99 10.08z";
    if (p == 85) return "M223.39 217.26c-5.85 3.38-14.52 11.27-14.37 10.97 5.45-10.5 14.73-11.17 14.37-10.97z";
    if (p == 86) return "M223.83 213.84c-3.32 2.58-9.14 3.42-15.45 10.87-1.21 1.43-4.92 3.6-4.63 3.27 1.33-1.53 2.71-3 3.97-4.6 6.48-8.24 16.45-9.81 16.11-9.54z";
    if (p == 87) return "M217.53 213.49c-1.88.89-3.7 1.7-5.36 2.97-1.75 1.34-7.21 8.01-8.86 9.39-1.82 1.52-6.78 3.54-6.42 3.28 1.9-1.37 4.12-2.45 5.52-4.34 8.12-10.97 15.49-11.47 15.12-11.3z";
    if (p == 88) return "M221.37 209.74c-2.93 1.36-17.14 9.18-16.94 8.91 4.25-5.49 17.13-9 16.94-8.91z";
    if (p == 89) return "M224.6 206.88c-8.77.77-15.32 6.21-14.79 5.96 0 .01 15.42-6.01 14.79-5.96z";
    if (p == 90) return "M207.07 212.04c.52-.38-6.57 6.1-9.08 9.84-2.33 3.48-7.53 10.33-7.34 10.02 2.42-3.91 3.7-8.29 6.47-12.05 2.55-3.47 6.57-5.32 9.95-7.81z";
    if (p == 91) return "M203.16 211.6c.47-.36-9.45 9.76-11.48 11.96-.23.25 2.09-4.79 3.9-6.62 2.18-2.21 5.15-3.46 7.58-5.34z";
    if (p == 92) return "M226.15 206.19c-11.69.21-34.94-.75-39.84 19.07-7.4 29.92 21.94 31.21 21.94 31.21s-.43-3.61 3.11-8.12c2.8-3.57 8.1-7.71 18.09-11.05 22.3-7.47 36.17-14.52 23.13-41.11 0-.01-11.35 9.73-26.43 10z";
    if (p == 93) return "M223.9 198.35s-35.99 10.14-61.45-5.57c0 0 22.04 21.69 61.45 5.57z";
    if (p == 94) return "M215.14 234.11s-6.63 6.17-7.09 17.23l4.47-3.13s-1-5.39 2.62-14.1z";
    if (p == 95) return "M219.31 235.37s-3.74 3.49-4.01 9.74l2.53-1.77s-.57-3.04 1.48-7.97z";
    if (p == 96) return "M159 226s3 14 14.25 20.14L179 245s-11-3-20-19z";
    if (p == 97) return "m75.71 236.71-7.29 23.44s-38.88-19.38-12.55-69.55c-.01 0-15.57 48.65 19.84 46.11z";
    if (p == 98) return "m71.23 251.1 4.48-14.39c-35.4 2.54-18.92-46.85-18.92-46.85-17.9 40.56 10.69 59.03 14.44 61.24z";
    if (p == 99) return "m75.71 236.71-7.29 23.44s-38.88-19.38-12.55-69.55c-.01 0-11.24 47.71 19.84 46.11z";
    if (p == 100) return "M42.73 183.97c2.18 12.18 13.68 20.31 25.68 18.16s19.96-13.77 17.78-25.94c-2.18-12.18-11.91-18.36-23.91-16.21s-21.73 11.81-19.55 23.99z";
    if (p == 101) return "M59.38 172.82c1.1 6.14 6.9 10.24 12.95 9.15 6.05-1.08 10.06-6.94 8.96-13.08-1.1-6.14-6-9.26-12.05-8.17s-10.96 5.97-9.86 12.1z";
    if (p == 102) return "M50.49 181.66c-.74-13.4 12.84-20.86 12.19-20.74-12 2.15-22.13 10.88-19.95 23.05 2.18 12.18 16.6 20.49 28.6 18.34 2.34-.42-19.85-2.86-20.84-20.65z";
    if (p == 103) return "M72.99 239.5s.01-5.93-12.23-6.75c-7.39-.49-15.41 5.78-19.68 14.92-7.44 15.94 8.76 20.94 3.6 33.06-2.92 6.87-11.71 9.93-11.71 9.93s21.79 1.75 27.19-8.61 12.83-42.55 12.83-42.55z";
    if (p == 104) return "M37.89 289.93s8.78-3.06 11.71-9.93c5.16-12.12-11.04-17.12-3.6-33.06 3.27-7.01 8.76-12.34 14.47-14.21-7.31-.32-15.18 5.91-19.39 14.93-7.44 15.94 8.76 20.94 3.6 33.06-2.92 6.87-11.71 9.93-11.71 9.93l4.92-.72z";
    if (p == 105) return "M60.04 279.88s-7.76-12.84-4.44-30.96c2.88-15.72 12.12-12.84 12.12-12.84s5.81-1.72 5.27 3.42-12.95 40.38-12.95 40.38z";
    if (p == 106) return "m295.82 99.06-75.87 189.3a4.64 4.64 0 0 0 2.62 6.02l9.47 3.72c2.81 1.11 6 .68 8.42-1.14a8.461 8.461 0 0 0 2.93-4.06l63.05-183.84";
    if (p == 107) return "M265.81 78.53c11.51 4.54 23.99 10.88 37.38 19.53l10.13-25.03s-80.58-76.47-138.47 6.79c0 0 27.2-20.73 77.07-6.08l13.89 4.79z";
    if (p == 108) return "m299.85 117.26-5.67-2.05c-3.26-1.18-4.81-5.22-3.47-9.02l12.62-35.54c1.35-3.8 5.09-5.92 8.35-4.74l5.67 2.05c3.26 1.18 4.81 5.22 3.47 9.02l-12.62 35.54c-1.35 3.8-5.09 5.93-8.35 4.74z";
    if (p == 109) return "M300.74 76.12s-7.03 8.74-24.08.34c-56.75-27.98-100.44 1.52-100.95 2.31 0 0 43.2-29.92 119.03 13.22l6-15.87z";
    if (p == 110) return "M195.57 65.68c44.78-38.72 118.29 20.75 118.29 20.75l4.1-10.02s-39.78-32.01-66.78-33.15";
    if (p == 111) return "M176.23 79.37c46.27-57.48 105.48-22.36 121.99-10.93 2.07 1.43 7.31 1.26 8.24-1.1 0 0-75.03-65.4-133.48 14.37 0 0-2.3-.09 3.25-2.34z";
    if (p == 112) return "M300.36 78.23c-57.24-39.85-100.94-15.74-104.91-13.15 22.79-16.89 65.88-17.47 106.52 10.76 1.47.66.06 3.28-.32 2.95-.01-.01-1.28-.56-1.29-.56z";
    if (p == 113) return "M305.5 67.34c-21.63-15.78-85.26-53.71-132.52 14.37 0 0 48.77-35.41 122.59 10.8";
    if (p == 114) return "m318.33 102.11-3.06 10.54c-1.93 6.64-6.21 12.45-12.22 15.88a25.97 25.97 0 0 1-11.88 3.42c-2.2.08-3.84-2-3.23-4.11l16.6-57.14-7.67-2.23-16.6 57.14c-.61 2.11-3.12 2.99-4.93 1.74-3.4-2.34-6.21-5.49-8.2-9.26-3.23-6.12-3.74-13.31-1.81-19.96l3.88-13.35-7.67-2.23-4.05 13.92c-1.28 4.4-1.66 8.93-1.13 13.45.51 4.36 1.85 8.54 3.98 12.41 2.13 3.87 4.93 7.23 8.34 10.01 2.01 1.63 4.17 3.02 6.47 4.14l-52.99 157.13c-.78 2.44.57 5.05 3.02 5.83l9.94 3.08c2.88.91 6.03.27 8.32-1.71a8.45 8.45 0 0 0 2.64-4.25l41.97-156.67c2.01.12 4.02.07 6.04-.17 4.36-.51 8.54-1.85 12.41-3.98 3.87-2.13 7.23-4.93 10.01-8.34a33.86 33.86 0 0 0 6.26-11.96l3.2-11.01a3.02 3.02 0 0 0-2.06-3.75l-1.95-.57c-1.55-.45-3.18.44-3.63 2z";
    if (p == 115) return "m235.46 300.35 45.58-157.2a8.084 8.084 0 0 1 5.34-5.48l-42.46 158.66c-.01 0-1.93 6.36-8.46 4.02z";
    if (p == 116) return "M270.83 64.91s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59 2.23 5.51 11.46 5.4 11.46 5.4-7.12-12.35-5.99-24.22-5.99-24.22z";
    if (p == 117) return "M270.83 64.91s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59";
    if (p == 118) return "M328.65 81.72s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59 2.23 5.51 11.46 5.4 11.46 5.4-7.12-12.35-5.99-24.22-5.99-24.22z";
    if (p == 119) return "M328.65 81.72s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59";
    if (p == 120) return "M305.9 51.7s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59 2.23 5.51 11.46 5.4 11.46 5.4-7.11-12.35-5.99-24.22-5.99-24.22z";
    if (p == 121) return "M305.9 51.7s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59";
    if (p == 122) return "M328.12 82.52s-5.41 10.63-18.04 17.23c0 0 7.73 5.04 12.57 1.59 2.23 5.51 11.46 5.4 11.46 5.4-7.12-12.34-5.99-24.22-5.99-24.22z";
    if (p == 123) return "M321.76 72.38c-3.64 12.55-17.02 38.65-32.98 34.02-16.01-4.64-13.31-33.84-9.67-46.39s16.46-19.61 27.85-16.31 18.44 16.12 14.8 28.68z";
    if (p == 124) return "M279.1 60.01c-3.64 12.55-6.34 41.75 9.67 46.39l18.12-38.82c3.53-7.56 3.55-16.3.06-23.88-11.39-3.3-24.21 3.76-27.85 16.31z";
    if (p == 125) return "M285.75 58.02c-10.08 36.5 22.02 53.89 3.03 48.38-16.01-4.64-13.31-33.84-9.67-46.39s16.46-19.61 27.85-16.31-15.92-4.86-21.21 14.32z";
    if (p == 126) return "M260.87 282.59c3.63-12.53 6.89-43.8-9.08-48.43-16.01-4.64-29.94 23.53-33.57 36.06-3.63 12.53 3.42 25.34 14.81 28.64s24.21-3.74 27.84-16.27z";
    if (p == 127) return "M218.22 270.22c3.63-12.53 17.57-40.71 33.57-36.06l-5.98 47.6c-1.06 8.27-5.78 12.58-12.78 17.11-11.39-3.31-18.44-16.11-14.81-28.65z";
    if (p == 128) return "M227.57 270.22c11.51-43.8 28.23-34.2 24.23-36.06-15.11-7.04-29.94 23.53-33.57 36.06-3.63 12.53 3.42 25.34 14.81 28.64s-10.52-9.42-5.47-28.64z";
    if (p == 129) return "M260.87 282.59c3.63-12.53 9.8-42.92-9.08-48.43-18.74-5.47-29.94 23.53-33.57 36.06-3.63 12.53 3.42 25.34 14.81 28.64s24.21-3.74 27.84-16.27z";
    if (p == 130) return "M248.3 246.99c-5.2-1.51-8.42-6.13-7.21-10.32l39.34-135.7c3.31-7.57 20.78-1.31 18.82 5.46l-39.34 135.7c-1.21 4.18-6.41 6.36-11.61 4.86z";
    if (p == 131) return "M243.65 245.64c-2.63-.76-3.77-4.78-2.55-8.97l39.34-135.7c2.8-7.72 11.47-4.01 9.51 2.76l-39.34 135.7c-1.22 4.19-4.34 6.97-6.96 6.21z";
    if (p == 132) return "M173.84 215.07c-.31-.17-.62-.33-.92-.5.41.22.72.39.92.5z";
    if (p == 133) return "m172.22 214.2-.62-.34c.2.11.41.22.62.34z";
    if (p == 134) return "M172.71 214.46c-.17-.09-.33-.18-.49-.27.17.1.34.19.49.27z";
    if (p == 135) return "M174.05 215.18c-.03-.01-.1-.05-.21-.11.07.04.13.07.21.11z";
    if (p == 136) return "M174.06 215.19s-.01 0-.01-.01c0 .01.01.01.01.01z";
    if (p == 137) return "M172.91 214.57c-.07-.04-.13-.07-.2-.11.07.04.14.08.2.11z";
    if (p == 138) return "M168.51 212.2c.14.08.28.15.42.23-.14-.08-.28-.16-.42-.23z";
    if (p == 139) return "M171.59 213.86c-.23-.12-.45-.24-.68-.36.24.12.47.25.68.36z";
    if (p == 140) return "M170.47 213.26c-.49-.26-1.01-.54-1.55-.83.5.26 1.02.54 1.55.83z";
    if (p == 141) return "M186.78 293.86h2.61c2.97 0 5.93-.51 8.71-1.55 9.93-3.68 31.1-15.4 39.87-50.01 2.16-8.53.45-22.04 1.27-28.53.35-2.72-4.14-5.96-4.47-5.72-21.46 15.53-60.73 7.14-60.73 7.14 32.3 17.39 16.83 56.12 16.83 56.12l-4.09 22.55z";
    if (p == 142) return "M170.92 213.5c-.03-.02-.06-.03-.09-.05.03.01.06.03.09.05z";
    if (p == 143) return "M170.83 213.45c-.12-.06-.24-.13-.35-.19.11.06.23.13.35.19z";
    if (p == 144) return "M215.4 223.82s-1.34 31.22 16.98 34.59c2.16-4.72 4.07-10.07 5.6-16.1 1.71-6.73 1-16.55 1.03-23.58-1.52-3.58-23.61 5.09-23.61 5.09z";
    if (p == 145) return "M129.88 249.52c-25.08-3.84-24.71 8.2-24.71 8.2l1.44 14.62-7.92 10.34 7.92 11.17h56.33c-.01.01-4.1-39.9-33.06-44.33z";
    return "";
  }
}