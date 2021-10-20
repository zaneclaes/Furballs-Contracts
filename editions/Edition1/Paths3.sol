// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPaths.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1Paths3 is IFurballPaths {
  function path(uint8 p) external pure override returns(bytes memory) {
    if (p == 0) return "m164.91 188.68-6.55-4.25a.724.724 0 0 1-.21-1l2.74-4.22c.22-.33.66-.43 1-.21l6.55 4.25c.33.22.43.66.21 1l-2.74 4.22c-.22.33-.66.43-1 .21z";
    if (p == 1) return "M138.62 115.92c-6.55-7.67-17.13-10.85-27.29-10.85s-16.49-3.67-16.49-3.67 13.84 34.53 33.65 35.36l6.16.62c2.52.25 4.75 1.72 6.01 3.91 0 0 11.58 2.6 14.93-20.12l-3.51-3.29s-6.91 5.7-13.46-1.96z";
    if (p == 2) return "M140.79 140.92c-1.26-2.2-3.61-3.3-6.13-3.55l-6.16-.62c-19.81-.83-33.65-35.36-33.65-35.36s6.34 3.67 16.49 3.67 20.48 3.41 27.29 10.85c7.94 8.68 13.7 2.68 13.7 2.68";
    if (p == 3) return "M142.72 126.76s-4.14.09-9.96-6.24c-5.08-5.53-14.4-8.88-21.84-7.56 0 0 8.47 25.19 31.8 13.8z";
    if (p == 4) return "M130 124.48c-6.84-8.7-18.12-10.32-18.12-10.32 10.99-3.65 17.76 2.4 20.92 6.37 5.36 6.73 11.34 5.95 11.34 5.95-7.83 3.82-15.83 1.23-21.22-1.04 6.18 1.39 8.4.72 7.08-.96z";
    if (p == 5) return "M142.7 126.75s-5.17.44-10.4-5.46c-4.05-4.57-12.2-9.11-22.85-8.33 0 0 11.86 24.24 33.25 13.79z";
    if (p == 6) return "M254 115.92c6.55-7.67 17.13-10.85 27.29-10.85s16.49-3.67 16.49-3.67-13.84 34.53-33.65 35.36l-6.16.62a7.841 7.841 0 0 0-6.01 3.91s-27.62-3.11-14.93-20.12l3.51-3.29s6.92 5.7 13.46-1.96z";
    if (p == 7) return "M240.3 118.6s5.76 6 13.7-2.68c6.81-7.44 17.13-10.85 27.29-10.85s16.49-3.67 16.49-3.67-13.84 34.53-33.65 35.36l-6.16.62c-2.52.25-4.87 1.36-6.13 3.55";
    if (p == 8) return "M249.9 126.76s4.14.09 9.96-6.24c5.08-5.53 14.4-8.88 21.84-7.56 0 0-8.47 25.19-31.8 13.8z";
    if (p == 9) return "M262.62 124.48c6.84-8.7 18.12-10.32 18.12-10.32-10.99-3.65-17.76 2.4-20.92 6.37-5.36 6.73-11.34 5.95-11.34 5.95 7.83 3.82 15.83 1.23 21.22-1.04-6.18 1.39-8.4.72-7.08-.96z";
    if (p == 10) return "M249.92 126.75s5.17.44 10.4-5.46c4.05-4.57 12.2-9.11 22.85-8.33 0 0-11.85 24.24-33.25 13.79z";
    if (p == 11) return "m165.65 106.2-3.36-5.57c-.43-.55-.55-1.28-.31-1.94l1-2.73c1.24-3.38 1.83-6.96 1.74-10.55l-.06-2.48c.16-.88-.97-1.39-1.52-.67l-5.13 9.8c-.29.37-.88.18-.89-.29l-.46-10.91c-.11-6.6-1.01-13.17-2.67-19.56l-6.01-16.86c-.31-1.31-2.12-1.46-2.63-.21-.23.57-.43 1.18-.6 1.81-.72 2.6-.84 5.32-.38 7.98 1.08 6.27 3.28 13.73 3.27 18.65-.01 3.18-.63 4.68-1.24 5.39-.41.47-1.06.66-1.67.52-.9-.21-1.89-.44-2.96-.68-.93-.21-1.66-.91-1.9-1.83l-1.43-5.37c-1.11-3.62-1.29-4.74-4.16-7.2L129 58.98l.82 2.13c1.75 4.52 3.23 9.86 1.67 14.43-4.37-1.08-9.23-3.5-12.6-4.97-16.93-7.41-6.94-18.7-6.94-18.7-8.23.35-12.7 12.11-5.23 19.69 4.62 4.69 29.49 13.2 29.49 13.2l7.39 2.44c1.83.6 3.16 2.19 3.43 4.1l.8 4.81c.17 1.17-.54 2.28-1.67 2.62l-.04.01c-.3.09-.61.12-.92.1-5.23-.46-11.61-3.27-15.15-5.01-1.67-.82-3.2-1.9-4.53-3.2l-4.57-4.45s-2.22-1.99-3.4-.94.05 2.77.05 2.77l2.85 3.65c4.2 5.37 9.93 9.32 16.44 11.33l5.73 2.12c4.87 1.5 9.61 7.37 11.4 12.14 0 0 10.29 0 12.5-5.55l.09-.7c.26-1.68-.09-3.36-.96-4.8z";
    if (p == 12) return "M150.1 63.22c5.37 13.26 2.69 32.4 2.22 38.92-.47-6.52 1.08-18.05-2.22-38.92z";
    if (p == 13) return "M155.5 95.62c-1.75 11.85 3 14.67 4.94 17.1-1.03-1.17-5.05-8.87-4.94-17.1z";
    if (p == 14) return "m136.49 80.08-.89-7.32.06 7.06c-1.81-.55-9.45-2.69-11.49-3.14 3.32 2.06 21.78 6.95 23.82 7.41-1.93-.78-9.62-3.42-11.5-4.01z";
    if (p == 15) return "M106.12 61.14c-2.22 8.94 11.84 13.24 13.5 13.72-1.61-.6-12.7-5.2-13.5-13.72z";
    if (p == 16) return "M149.56 61.48c-.26-.58-1.67-6.66-1.69-7.3.26.58 1.9 3.43 1.69 7.3z";
    if (p == 17) return "M145.3 101.98c7.84-.98 9.78 5.33 9.76 6.43-2.74-5.55-8.73-6.1-9.76-6.43z";
    if (p == 18) return "m227.07 106.2 3.36-5.57c.43-.55.55-1.28.31-1.94l-1-2.73A28.557 28.557 0 0 1 228 85.41l.06-2.48c-.16-.88.97-1.39 1.52-.67l5.13 9.8c.29.37.88.18.89-.29l.46-10.91c.11-6.6 1.01-13.17 2.67-19.56l6.01-16.86c.31-1.31 2.12-1.46 2.63-.21.23.57.43 1.18.6 1.81.72 2.6.84 5.32.38 7.98-1.08 6.27-3.28 13.73-3.27 18.65.01 3.18.63 4.68 1.24 5.39.41.47 1.06.66 1.67.52.9-.21 1.89-.44 2.96-.68.93-.21 1.66-.91 1.9-1.83l1.43-5.37c1.11-3.62 1.29-4.74 4.16-7.2l5.26-4.51-.82 2.13c-1.75 4.52-3.23 9.86-1.67 14.43 4.37-1.08 9.23-3.5 12.6-4.97 16.93-7.41 6.94-18.7 6.94-18.7 8.23.35 12.7 12.11 5.23 19.69-4.62 4.69-29.49 13.2-29.49 13.2l-7.39 2.44c-1.83.6-3.16 2.19-3.43 4.1l-.8 4.81c-.17 1.17.54 2.28 1.67 2.62l.04.01c.3.09.61.12.92.1 5.23-.46 11.61-3.27 15.15-5.01 1.67-.82 3.2-1.9 4.53-3.2l4.57-4.45s2.22-1.99 3.4-.94c1.18 1.05-.05 2.77-.05 2.77l-2.85 3.65c-4.2 5.37-9.93 9.32-16.44 11.33l-5.73 2.12c-4.87 1.5-9.61 7.37-11.4 12.14 0 0-4.23 4.19-10.68-.88-.02-.03-5.32-4.4-.93-10.18z";
    if (p == 19) return "M242.62 63.22c-5.37 13.26-2.69 32.4-2.22 38.92.47-6.52-1.08-18.05 2.22-38.92z";
    if (p == 20) return "M237.22 95.62c1.75 11.85-3 14.67-4.94 17.1 1.03-1.17 5.05-8.87 4.94-17.1z";
    if (p == 21) return "m256.23 80.08.89-7.32-.06 7.06c1.81-.55 9.45-2.69 11.49-3.14-3.32 2.06-21.78 6.95-23.82 7.41 1.93-.78 9.62-3.42 11.5-4.01z";
    if (p == 22) return "M286.6 61.14c2.22 8.94-11.84 13.24-13.5 13.72 1.61-.6 12.7-5.2 13.5-13.72z";
    if (p == 23) return "M243.16 61.48c.26-.58 1.67-6.66 1.69-7.3-.26.58-1.9 3.43-1.69 7.3z";
    if (p == 24) return "M247.42 101.98c-7.84-.98-9.78 5.33-9.76 6.43 2.74-5.55 8.73-6.1 9.76-6.43z";
    if (p == 25) return "M173.29 123.89c-.05 0-.09-.77-.13-.77-4.27 0-7.74 3.47-7.74 7.74s3.47 7.74 7.74 7.74c2.84 0 5.31-1.53 6.66-3.81-1.25-4.41-3.51-7.63-6.53-10.9z";
    if (p == 26) return "M244.21 123.89c-.05 0-.09-.77-.13-.77-4.27 0-7.74 3.47-7.74 7.74s3.47 7.74 7.74 7.74c2.84 0 5.31-1.53 6.66-3.81-1.25-4.41-3.51-7.63-6.53-10.9z";
    if (p == 27) return "M187 157.48c4.27 1.17 7.49 6.24 7.49 12.31 0 5.47-2.61 10.12-6.24 11.85";
    if (p == 28) return "M204.88 170.08c0 3.92-4.03 7.09-8.99 7.09s-2.13-3.17-2.13-7.09-2.84-7.09 2.13-7.09 8.99 3.17 8.99 7.09z";
    if (p == 29) return "M225.2 146.17c-9.88.02-18.31 6.2-21.68 14.89-1.07 2.76-1.54 4.61-4.5 4.61h-.11c-1.87 0-3.38 1.51-3.38 3.38v.84c0 1.87 1.51 3.38 3.38 3.38h.11c2.93 0 3.42 1.8 4.47 4.54 3.35 8.75 11.83 14.97 21.77 14.97 12.93 0 23.4-10.53 23.3-23.49-.1-12.76-10.59-23.15-23.36-23.12z";
    if (p == 30) return "M239.42 151a23.13 23.13 0 0 1 4.82 13.98c.1 12.95-10.37 23.49-23.3 23.49-5.33 0-10.25-1.79-14.17-4.81 4.26 5.55 10.96 9.13 18.49 9.13 12.93 0 23.4-10.53 23.3-23.49-.06-7.44-3.64-14.06-9.14-18.3z";
    if (p == 31) return "M209.39 176.68c-.73 0-1.47-.44-1.65-1.18-3.7-15.26 6.08-22.16 12.88-23.9.94-.24 1.89.33 2.13 1.26.24.94-.32 1.89-1.26 2.13-5.51 1.41-13.61 7.05-10.44 19.37.24.94-.17 1.91-1.09 2.22-.19.07-.38.1-.57.1z";
    if (p == 32) return "M175.73 105.86s-6.55-5.08-4.69-8.5c2.3-4.23 7.92 2.28 7.92 2.28s1.26-10.26 7.14-12.3c1.62-.56.24 7.68 1.92 12.24 0 0 4.2-15.72 10.32-15.72 1.44 0-.18 10.14-.18 10.14s4.95-9.38 10.86-6.78c1.5.66-2.1 7.5-2.1 7.5s6.59-4.98 10.62-3.18c4.56 2.04-5.28 8.04-5.28 8.04s2.99-2.01 5.94-2.19c2.06-.12 3.25 2.3 1.92 3.87-1.22 1.45-3.78 3.43-5.31 5.02";
    if (p == 33) return "M211.31 100.12c0 4.35 8.14-1.56 8.21-1.56.24-.84-8.21 2.13-8.21 1.56z";
    if (p == 34) return "M173.2 100.36c1.41-2.59 4.07-1.15 5.92.36.9.74 2.27.29 2.56-.84.72-2.83 2.27-7.09 5.35-8.95-.07-2.25-.18-3.84-.92-3.59-5.88 2.04-7.14 12.3-7.14 12.3s-5.62-6.51-7.92-2.28c-.9 1.65.41 3.53 2.01 5.03-.22-.69-.21-1.38.14-2.03z";
    if (p == 35) return "M190.15 100.37c1.53-3.72 5.98-11.92 8.76-13.16-2.11-8.91-11.83 12.58-11.83 12.6.05 1.72 2.41 2.15 3.07.56z";
    if (p == 36) return "M199.98 96.11c2.3-3.08 6.38-7.02 9.34-7.03.38-1.25-5.65-3.84-11.3 6.27-.54.97 1.3 1.65 1.96.76z";
    if (p == 37) return "M210.02 96.8c2.66-1.38 6.15-2.88 8.38-2.61.58-1.06-2.3-4.23-10.76.65-.01.02-.01.04-.02.07-.35 1.4 1.12 2.55 2.4 1.89z";
    if (p == 38) return "M174.68 104.75s-5.5-3.97-3.64-7.39c2.3-4.23 7.92 2.28 7.92 2.28s1.26-10.26 7.14-12.3c1.62-.56.24 7.68 1.92 12.24 0 0 4.2-15.72 10.32-15.72 1.44 0-.18 10.14-.18 10.14s4.95-9.38 10.86-6.78c1.5.66-2.1 7.5-2.1 7.5s6.59-4.98 10.62-3.18c4.56 2.04-5.28 8.04-5.28 8.04s2.99-2.01 5.94-2.19c2.06-.12 3.25 2.3 1.92 3.87-1.22 1.45-1.53.95-3.06 2.54";
    if (p == 39) return "M184.33 95.79s-2.08 2.47-.8 5.85c.1.26.43.35.7.31.56-.07.85-.73.49-1.18-.7-.91-1.16-2.17-.39-4.98z";
    if (p == 40) return "M205.02 92.59s-2.88 1.41-3.13 5.01c-.02.27.24.49.5.56.54.16 1.06-.33.93-.88-.26-1.11-.15-2.44 1.7-4.69z";
    if (p == 41) return "M216.1 101.37s-.75 1.77-2.88 2.04c-.16.02-.3-.13-.35-.28-.11-.31.16-.64.49-.58.67.11 1.46 0 2.74-1.18z";
    if (p == 42) return "M227.93 261.1c-4.66-1.09-10.56 2.61-14.33 2.61-3.77 0 1.13-3.05-1.09-3.94-2.22-.89-6.11-2.3-10.78.72-1.19.77 2.52.92.44 2.4-1.94 1.38-4.7 1.91-8.05 1.91-3.35 0-6.12-.53-8.05-1.91-2.08-1.48.98-1.09.44-2.4-.54-1.31-7.23-3.01-10.78-.72-2.01 1.3 2.88 2.84-.89 2.84s-9.87-2.6-14.53-1.5c0-2.06 3.23-9.87 9.08-17.06 2.03.43 47.42.43 49.45 0 5.86 7.18 9.09 15 9.09 17.05z";
    if (p == 43) return "M227.93 261.1c-4.66-1.09-10.56 2.61-14.33 2.61-3.77 0 1.13-3.05-1.09-3.94-2.22-.89-6.11-2.3-10.78.72-1.19.77 2.52.92.44 2.4-1.94 1.38-4.7 1.91-8.05 1.91-3.35 0-6.12-.53-8.05-1.91-2.08-1.48.98-1.09.44-2.4-.54-1.31-7.23-3.01-10.78-.72-2.01 1.3 2.88 2.84-.89 2.84s-9.87-2.6-14.53-1.5c0-2.06 3.23-9.87 9.08-17.06 2.03.43 42.69-4.6 49.45 0 5.86 7.18 9.09 15 9.09 17.05z";
    if (p == 44) return "M223.31 246.37c-2.4-.56-5.25.01-7.84.56-1.75.37-3.39.74-4.7.74-3.26 0 1.15-1.68-.77-2.45-1.91-.77-4.68-1.43-9.31.62-1.12.49 2.18.8.38 2.07-1.67 1.19-4.06 1.65-6.95 1.65-2.89 0-5.28-.46-6.95-1.65-1.79-1.28.81-.93.38-2.07-.59-1.56-5.87-3-9.31-.62-1.7 1.18 2.49 2.45-.77 2.45-1.31 0-2.95-.36-4.7-.74-2.6-.55-5.44-1.12-7.84-.56 0-1.78 2.79-8.53 7.84-14.73 6.61-1.94 41.47.12 42.7 0 5.05 6.2 7.84 12.95 7.84 14.73z";
    if (p == 45) return "M215.47 231.64c5.05 6.21 7.84 12.96 7.84 14.73-2.4-.56-5.25.01-7.84.56-1.75.37-3.39.74-4.7.74-3.26 0 1.15-1.68-.77-2.45-1.91-.77-4.68-1.43-9.31.62-1.12.49 2.18.8.38 2.07-1.67 1.19-4.06 1.65-6.95 1.65-2.89 0-5.28-.46-6.95-1.65-1.79-1.28.81-.93.38-2.07-.59-1.56-5.87-3-9.31-.62-1.7 1.18 2.49 2.45-.77 2.45-1.31 0-2.95-.36-4.7-.74-2.6-.55-5.44-1.12-7.84-.56 0-1.78 2.79-8.53 7.84-14.73";
    if (p == 46) return "m204.88 214.36 8.83 17.61c-1.34.28-5.84.93-6.84.93-2.49 0 .73-1.01-.59-1.88-2.28-1.51-6.78-.39-7.13.47-.36.87 1.67.61.29 1.59-1.28.91-3.11 1.26-5.33 1.26s-4.05-.35-5.33-1.26c-1.37-.98.65-.72.29-1.59-.36-.86-4.05-1.86-7.13-.47-1.44.65 1.91 1.88-.59 1.88-1.01 0-5.68-.26-7.02-.54l8.29-18.11c6.18-1.5 17.08-1.45 23.25.11h-.99z";
    if (p == 47) return "m185.68 214.36-11.16 19.44s-45.96-28.32-46.8-35.64c0 0-1.68-7.56 2.64-13.08 0 0 23.52 26.52 55.32 29.28z";
    if (p == 48) return "m204.16 214.12 9.72 20.28s23.04-10.56 29.4-20.16c0 0 2.3-4.32-1.8-9.72 0 0-23.88 8.76-37.32 9.6z";
    if (p == 49) return "M223.9 203.35s-35.99 10.14-61.45-5.57c0 0 22.04 21.69 61.45 5.57z";
    if (p == 50) return "m208.45 231.64-3.13-6.79c-.21-.45-.88-.24-.8.25L206 234l2.45-2.36z";
    if (p == 51) return "m199.92 233.62.09-7.49c.01-.49-.69-.59-.82-.12l-2.48 8.7 3.21-1.09z";
    if (p == 52) return "m190.9 233.14-1.7-8.3c-.11-.48-.81-.41-.83.08l-.35 9.02 2.88-.8z";
    if (p == 53) return "m182.15 232.35 2.4-7.24c.11-.48-.55-.72-.78-.28l-4.98 7.94 3.36-.42z";
    if (p == 54) return "m212.91 246.96-4.45-11.1c-.23-.59-.97-.31-.88.32l1.63 11.73 3.7-.95z";
    if (p == 55) return "m202.54 247.42-.34-10.97c.01-.65-.76-.78-.9-.16l-3.21 12.56 4.45-1.43z";
    if (p == 56) return "m216.31 262.84-5.43-11.61c-.28-.59-1.18-.31-1.07.32l2.47 11.29h4.03z";
    if (p == 57) return "m203.62 262.78-.42-10.97c.01-.65-.93-.78-1.11-.16l-3.32 12.74 4.85-1.61z";
    if (p == 58) return "m189.79 248.17-2.76-12.31c-.12-.63-.89-.54-.91.1l-.38 11.88 4.05.33z";
    if (p == 59) return "m179.29 245.74 1.9-9.52c.12-.63-.61-.95-.86-.37l-4.73 10.45 3.69-.56z";
    if (p == 60) return "m188.82 263.22-2.56-11.53c-.14-.75-1.06-.64-1.08.12l-.22 10.77 3.86.64z";
    if (p == 61) return "m176.68 262.57 2.24-11.27c.14-.75-.72-1.12-1.02-.44l-6.15 12.1 4.93-.39z";
    if (p == 62) return "M82 221.2c-23.02-14.32-26.52-63.42-7.56-75.84 0 0-18.55-3.66-22.75 23.49l-4.24-19.43S34 171.15 42.3 184.78l-11.9-14.12s-2.77 33.22 16.13 47.72l-13.45-6.81s6.66 30.57 37.74 36.92c0 0 33.57-13.36 11.18-27.29z";
    if (p == 63) return "M73.4 146.1c.34-.26.68-.51 1.04-.74 0 0-2.82-.56-6.51.37 2.56-.23 4.57.15 5.47.37z";
    if (p == 64) return "m34.37 212.22-1.29-.65s.09.4.29 1.13l3.57 2.42c-.93-.93-1.78-1.9-2.57-2.9z";
    if (p == 65) return "M83 222.2c-21.2-8.09-27.64-60.47-11.81-76.1-18.32 13.12-25.31 60 5.5 87.89 10.55 9.57 11.11-9.96 6.31-11.79z";
    if (p == 66) return "M55.77 170.05c3-19.38 10.51-21.69 16.51-23.97-2.84-.29-16.08.6-20.04 21.72-.37 1.97 1.92 3.96 3.53 2.25z";
    if (p == 67) return "M43.07 184.81c-6.54-16.07.96-28.32 4.37-32.73 0 0-4.12 33.35-4.37 32.73z";
    if (p == 68) return "M79.57 243.97c-29.79-3.72-45.2-31.76-45.2-31.76s6.12 30.75 37.2 37.11l8-5.35z";
    if (p == 69) return "M50.8 216.28C34.96 195.76 31.48 172 31.48 172s-1.56 30.6 15 46.44c0 0 6.28.37 4.32-2.16z";
    if (p == 70) return "M83 222.2c-22.32-8.52-27.52-64.42-8.56-76.84 0 0-18.55-3.66-22.75 23.49l-4.24-19.43S34 171.15 42.3 184.78l-11.9-14.12s-2.77 33.22 16.13 47.72l-13.45-6.81s6.66 30.57 37.74 36.92";
    if (p == 71) return "M66.47 132.28s16.35 16.35-13.62 45.63-17.03 67.42 8.17 70.83l16.37-8.85s-12.1-10.08 2.02-29.97c14.98-21.11 27.24-60.61-12.94-77.64z";
    if (p == 72) return "M38.25 199.97c2.72 12 11.4 38.14 34.61 31.21 1.04 5.78 4.53 8.7 4.53 8.7l-16.37 8.85c-19.14-2.58-31.2-25.2-22.77-48.76z";
    if (p == 73) return "M58.8 171.58c7.71-9.01 10.9-16.59 11.82-22.61 3.72 3.79 9.74 12.36 8.79 27.58-.95 15.17-2.22 26.37.3 32.94-.1.15-.2.29-.3.44-2.54 3.58-4.22 6.84-5.29 9.78-13.96-12.14-15.69-34.54-15.32-48.13z";
    if (p == 74) return "M58.8 171.58c7.71-9.01 10.9-16.59 11.82-22.61 3.72 3.79 9.74 12.36 8.79 27.58-.95 15.17-.48 22.72 2.04 29.29-.1.15-1.94 3.94-2.04 4.09-2.54 3.58-4.22 6.84-5.29 9.78-13.96-12.14-15.69-34.54-15.32-48.13z";
    if (p == 75) return "M79.41 176.55c.85-13.55-4.91-22.9-8.81-27.46 1.71-10.96-4.13-16.8-4.13-16.8 38.26 16.21 28.97 52.8 15.06 74.49-1.95-6.76-2.95-16.98-2.12-30.23z";
    if (p == 76) return "M67.14 244.11s-13.1-11.32 1.01-31.2c13.73-19.34 30-56.75 1.23-75.85-1.29-3.15-2.91-4.78-2.91-4.78 40.18 17.03 27.92 56.53 12.94 77.64-14.11 19.89-2.02 29.97-2.02 29.97l-16.37 8.85c-1.03-.14-2.04-.34-3.03-.59l9.15-4.04z";
    if (p == 77) return "M52.85 177.91c29.97-29.29 13.62-45.63 13.62-45.63.55.23 1.09.47 1.62.71-.15-.06-.3-.13-.45-.19 0 0 22.59 15.83-7.38 45.11-27.85 27.22-18.64 62.08 3.03 69.6l-2.27 1.23c-25.2-3.41-38.14-41.54-8.17-70.83z";
    if (p == 78) return "M39.08 198.82c.27 12.76 10.22 39.29 33.42 32.37";
    if (p == 79) return "M70.62 148.97c3.72 3.79 9.74 12.36 8.79 27.58-.95 15.17-2.22 25.77.3 32.34";
    if (p == 80) return "M73.52 219.7c-13.96-12.13-15.09-33.94-14.72-47.53";
    if (p == 81) return "M294.67 57.37s-73.95-50.61-132.5 15.15c-54.99 61.76-89.05 55.82-89.05 55.82s61.78 16.16 134.83-17.18c47.57-21.72 87.17 6.6 87.17 6.6";
    if (p == 82) return "M300.88 89.2s-69.84-59.76-115.2-13.68c-58.01 58.93-112.56 52.82-112.56 52.82s61.78 16.16 134.83-17.18c47.57-21.72 87.17 6.6 87.17 6.6";
    if (p == 83) return "M297.4 103.36s-53.76-53.76-114.96-5.88c-65.13 50.95-109.32 30.86-109.32 30.86s61.78 16.16 134.83-17.18c47.57-21.72 87.17 6.6 87.17 6.6";
    if (p == 84) return "m301.47 45.42 4.64 16.53c1.07 3.81 3.74 6.96 7.32 8.64l15.54 7.3c2.55 1.2 2.82 4.73.47 6.29l-14.29 9.52a13.639 13.639 0 0 0-5.96 9.63l-2.14 17.04c-.35 2.8-3.63 4.14-5.84 2.39l-13.47-10.65c-3.1-2.45-7.11-3.43-11-2.69l-16.86 3.23c-2.77.53-5.06-2.17-4.08-4.82l5.97-16.1c1.37-3.71 1.07-7.83-.84-11.29l-8.28-15.04c-1.36-2.47.5-5.48 3.32-5.37l17.15.7a13.6 13.6 0 0 0 10.48-4.29l11.74-12.53c1.93-2.05 5.37-1.21 6.13 1.51z";
    if (p == 85) return "M308.63 68.82c.69.43 20.02 10.07 20.02 10.07 2.44 1.14 1.15 3.96-1.1 5.46 0 0-18.35 10.93-18.02 13.94l-3.35 20.6c-.34 2.67-3.46 3.95-5.57 2.28L287.1 110.4c-.71-1.09-7.83-2.83-8.96-2.19l-16.96 3.31c-2.64.51-4.32 1.33-3.39-1.19l8.28-15.53c1.92-2.65 2.73-5.97 2.08-9.18-.01-.04-.01-.07-.02-.11-.38-1.79-1.22-3.45-2.37-4.88L254.1 62.66s26.94 3.58 28.95 2.91c1.67-.56 15.61-21.84 15.61-21.84 1.84-1.98 7.66 23.67 9.97 25.09z";
    if (p == 86) return "m294.29 118.71.83-3.4c1.75-7.16-2.63-14.38-9.79-16.13-7.16-1.75-14.38 2.63-16.13 9.79l-.76 3.1 5.79-1.11c5.24-1.01 10.67.32 14.86 3.63l5.2 4.12z";
    if (p == 87) return "m328.96 77.88-15.54-7.3a13.602 13.602 0 0 1-7.32-8.64l-4.64-16.53c-.76-2.72-3.08-2.64-2.81-1.7l1.42 20.42c.37 4.59 2.68 8.7 6.25 10.38l23.55 6.65-20.79 9.92c-3.25 1.73-5.85 2.01-5.77 5.34l1.08 26.98c.86.16 2.3-.25 2.65-3.05l2.14-17.04c.49-3.92 2.67-7.44 5.96-9.63l14.29-9.52c2.35-1.55 2.09-5.08-.47-6.28z";
    if (p == 88) return "M245.89 259.11c-5.59-1.37-9.01-7.01-7.64-12.59l32.54-132.49c1.37-5.59 7.01-9.01 12.59-7.64 5.59 1.37 9.01 7.01 7.64 12.59l-32.54 132.49c-1.36 5.58-7 9.01-12.59 7.64z";
    if (p == 89) return "m244.83 248.12 32.54-132.49c1.08-4.44 4.86-7.5 9.17-7.89-.95-.61-2-1.08-3.15-1.36-5.59-1.37-11.23 2.06-12.59 7.64l-32.54 132.49c-1.37 5.59 2.06 11.23 7.64 12.59 1.15.28 2.31.35 3.43.25-3.65-2.33-5.59-6.79-4.5-11.23z";
    if (p == 90) return "M283.39 106.38c-1.25-.31-2.5-.36-3.7-.22 3.49 2.38 5.32 6.74 4.26 11.08l-32.54 132.49c-1.06 4.34-4.7 7.36-8.89 7.86 1 .68 2.13 1.21 3.38 1.52 5.59 1.37 11.23-2.06 12.59-7.64l32.54-132.49c1.37-5.59-2.05-11.23-7.64-12.6z";
    if (p == 91) return "M245.89 259.11c-5.59-1.37-9.01-7.01-7.64-12.59l32.54-132.49c1.37-5.59 7.01-9.01 12.59-7.64 5.59 1.37 9.01 7.01 7.64 12.59l-32.99 132.37c-1.35 5.58-6.55 9.13-12.14 7.76z";
    if (p == 92) return "M256.9 254.97a10.408 10.408 0 0 1-11 4.13c-4.28-1.05-7.29-4.6-7.85-8.71-7.98 1.76-14.67 7.88-16.74 16.35-2.9 11.86 4.36 23.83 16.23 26.73 11.86 2.9 23.83-4.36 26.73-16.23 2.06-8.49-1.07-17.03-7.37-22.27z";
    if (p == 93) return "M128.08 199.51c-.65-.9-1.04-1.96-1.22-3.04a9.69 9.69 0 0 1 .03-3.31c.22-1.11.61-2.23 1.41-3.26.39-.52.92-.97 1.56-1.31.31-.17.68-.25 1.02-.36.35-.06.71-.07 1.06-.08.79-.01 1.43.63 1.44 1.42 0 .7-.5 1.29-1.16 1.41l-.27.05c-.57.11-1.01.28-1.55.74-.52.46-.96 1.18-1.25 1.98-.58 1.6-.75 3.54-.09 5.18l.01.03c.12.29-.02.62-.31.74-.26.11-.54.02-.68-.19z";
    if (p == 94) return "M126.94 200.98c-8.64-2.04-19.68.24-19.68.24 4.29.37 7.9 5.63 7.68 5.52-3.47-1.82-11.64-3.24-27.36 1.44 0 0 10.17 1.75 13.92 6.36.16.2-15.54-2.84-29.64 7.32 0 0 9.84-.37 13.08 2 .41.3.2.96-.32.94-4.1-.12-14.91-1.64-25.97 14.82 0 0 6.38-4.03 15.28-1.27.17.05.13.3-.04.3-2.55.08-8.5-1.71-15.47 10.2-3.72 6.36-10.08 7.08-10.08 7.08s3.65 8.04 10.04 6.14c6.41-1.91-7.9 3.66-9.8 20.62 0 0 3.62-5.01 12.46-5.01 0 0 1.1 6.21-7.3 14.01 0 0 19.2 5.76 24.24 1.32";
    if (p == 95) return "M137.02 152.14c-9.72.84-11.76 9-11.76 9s5.4-2.16 5.88-2.04c1.08.27-8.52-.96-7.92 18 0 0 3.36-.72 7.08-1.92";
    if (p == 96) return "M131.63 158.82c.79.47-.87.94-.87.94-2.09.49-3.76 2.16-4.72 4.12-1 1.96-1.44 4.2-1.61 6.43-.16 2.24.57 4.69.57 4.69s3.7-.88 4.84-1.25h.01c.79-.25 1.63.18 1.89.97.25.79-.18 1.63-.97 1.89-1.19.38-9.09 2.37-9.09 2.37s1.33-12.98 3.28-15.69c1.05-1.29-1.52 1.52-1.52 1.52s1.57-11.8 13.46-14.16c.83-.07 1.55.54 1.62 1.37s-.54 1.55-1.37 1.62c-2.39.21-4.69.96-6.53 2.36 0 0-2.69 2.17-4.16 4.59 0 0 3.54-2.59 5.17-1.77z";
    if (p == 97) return "M127.69 170.77c-.69-2.77 2.78-8.13 3.51-8.73-5.2 3.96-4.75 9.76-4.71 9.84.13.3.48.44.78.31 0 0 4.63-1.41 7.17-1.51-1.22-.43-6.43-.03-6.75.09z";
    if (p == 98) return "M92.2 225.28s-3.67-6.23-11.76-8.41c0 0 5.4-1.56 11.49 1.94 0 0-3.17-4.32-5.6-5.28";
    if (p == 99) return "M66.71 272.78s-8.66-.81-14.09.77c0 0 6.17-5.54 11.86-6.29";
    if (p == 100) return "M60.78 289.74s11.62 2.37 15.73-3.99";
    if (p == 101) return "M141.76 135.52c-11 0-19.92-8.92-19.92-19.92s8.92-19.92 19.92-19.92c9.31 0 17.13 6.39 19.31 15.02l1.09 3.7-15.6 22.8-4.8-1.68z";
    if (p == 102) return "M142.93 135.52c-11 0-21.09-8.92-21.09-19.92s8.92-19.92 19.92-19.92c9.31 0 17.13 6.39 19.31 15.02";
    if (p == 103) return "M142.93 105.47c-4.18 0-7.82 2.32-9.69 5.75 1.86-1.43 4.19-2.28 6.72-2.28 6.1 0 11.05 4.95 11.05 11.05 0 1.92-.49 3.72-1.35 5.3 2.63-2.02 4.32-5.19 4.32-8.76 0-6.11-4.95-11.06-11.05-11.06z";
    if (p == 104) return "M134.72 109.14c2.02-2.25 4.95-3.66 8.22-3.66 6.1 0 12.04 4.16 11.05 13.47";
    if (p == 105) return "M250.43 135.64c11 0 19.92-8.92 19.92-19.92s-8.92-19.92-19.92-19.92c-9.31 0-17.13 6.39-19.31 15.02l-1.09 3.7 15.6 22.8 4.8-1.68z";
    if (p == 106) return "M250.43 135.64c11 0 19.92-8.92 19.92-19.92s-8.92-19.92-19.92-19.92c-9.31 0-17.13 6.39-19.31 15.02";
    if (p == 107) return "M249.25 105.59c4.18 0 7.82 2.32 9.69 5.75a10.986 10.986 0 0 0-6.72-2.28c-6.1 0-11.05 4.95-11.05 11.05 0 1.92.49 3.72 1.35 5.3a11.014 11.014 0 0 1-4.32-8.76c.01-6.11 4.95-11.06 11.05-11.06z";
    if (p == 108) return "M257.47 109.26a11.003 11.003 0 0 0-8.22-3.66c-6.1 0-12.04 4.16-11.05 13.47";
    if (p == 109) return "M147.55 131.16s-13.77-17.66-23.15-2.66c-9.83 15.72 14.12 26.09 14.12 26.09";
    if (p == 110) return "M144.99 129.2s-11.21-15.7-20.59-.7c-9.83 15.72 10.77 23.67 10.77 23.67";
    if (p == 111) return "M139.36 141.97c5.64-5.37-5.64-11.38-5.64-11.38s-4.82.72-4.99 4.95c-.14 3.43 5.69 11.13 10.63 6.43z";
    if (p == 112) return "M130.1 131.52s8.42-5.76 10.1 9.15";
    if (p == 113) return "M245.27 131.16s13.77-17.66 23.15-2.66c9.83 15.72-14.12 26.09-14.12 26.09";
    if (p == 114) return "M247.83 129.54s11.21-16.05 20.59-1.04c9.83 15.72-10.77 23.67-10.77 23.67";
    if (p == 115) return "M253.46 141.97c-5.64-5.37 5.46-11.38 5.46-11.38s5.01.72 5.17 4.95c.14 3.43-5.69 11.13-10.63 6.43z";
    if (p == 116) return "M262.72 131.52s-8.42-5.76-10.1 9.15";
    if (p == 117) return "M170.98 128.04c-.04 0-.07-.01-.11-.01-3.47 0-6.28 2.81-6.28 6.28s2.81 6.28 6.28 6.28c2.3 0 4.31-1.24 5.4-3.09a23.34 23.34 0 0 0-5.29-9.46z";
    if (p == 118) return "m217.25 119.79 18.42 1.19-17.81 4.85a3.078 3.078 0 1 1-.61-6.04z";
    return "";
  }
}