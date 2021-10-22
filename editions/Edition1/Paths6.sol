// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.2;

import "../IFurballPaths.sol";

/// @author LFG Gaming LLC
contract FurballsEdition1Paths6 is IFurballPaths {
  function path(uint8 p) external pure override returns(bytes memory) {
    if (p == 0) return "M75.87 170.16c-9.12-3.34-17.32-.86-22.47 1.71-1.22 1.49-13.7 13.71-16.34 19.02 5.95-5.09 16.46-9.63 27.29-5.87 14.19 4.92 17.09 14.54 17.66 18.98 4.1-4.31 8.72-8.39 12.61-13.22-1.79-5.03-6.98-16.31-18.75-20.62z";
    if (p == 1) return "M71.01 223.43c.47-2.24 1.35-4.9 2.8-8.04-3.05-4.18-9.6-10.96-20.22-11.2-11.73-.27-17.1 10.98-18.99 16.34 1.4 5.8 4.12 11.51 8.26 16.94 1.26-4.41 4.12-11.28 10.3-15.34 7.81-5.12 15.29-.59 17.85 1.3z";
    if (p == 2) return "M65.12 244.28c-22.25-6.8-34.72-43.34-14.61-70.73-26.81 26.05-22.23 56.52 6.23 77.24 24.27 17.67 23.01.66 21.72-6.24-3.18-.96-6.84 1.72-13.34-.27z";
    if (p == 3) return "M73.16 234.45s-6.43-4.19.88-19.55 28.99-22.16 29.07-45.06c.1-27.82-34.9-42.64-43.08-43.33 0 0 8.73 9.25 9.23 13.27 0 0-8.63-2.57-10.37-2.76 0 0 10.21 16.9-11.89 39.2s-20.05 52.9 9.73 74.58 16.43-16.35 16.43-16.35";
    if (p == 4) return "M300.68 53.47c-23.61-6.22-47.79 7.89-54.01 31.5s7.89 47.79 31.5 54.01c23.61 6.22 47.79-7.89 54.01-31.5s-7.88-47.79-31.5-54.01zm-19.07 72.45c-16.4-4.32-26.19-21.11-21.88-37.51 4.32-16.4 21.11-26.19 37.51-21.88s26.19 21.11 21.88 37.51c-4.32 16.4-21.11 26.2-37.51 21.88z";
    if (p == 5) return "m287.28 140.89-14.85-3.76-46.15 157.85h.01c-.02.05-.04.1-.05.15-.53 2 3.57 4.82 9.16 6.29 5.58 1.47 10.54 1.04 11.07-.96l.03-.16h.01l40.77-159.41z";
    if (p == 6) return "m271.83 137.14-46.15 157.85h.01c-.02.05-.04.1-.05.15-.53 2 3.57 4.82 9.16 6.29 5.58 1.47 10.54 1.04 11.07-.96l.03-.16h.01l40.77-159.42";
    if (p == 7) return "M300.68 53.47c-23.61-6.22-47.79 7.89-54.01 31.5s7.89 47.79 31.5 54.01c23.61 6.22 47.79-7.89 54.01-31.5s-7.88-47.79-31.5-54.01z";
    if (p == 8) return "M268.9 60.78c-37.71 1.32-72.64-15.81-80.18-17.87-19.27-5.28-39.97-1.14-55.54 11.39-16.08 12.94-30.96 33.01-30.53 55.23.74 38.1 36.99 68.3 75.09 67.56 0 0 30.24-.74 61.02-24.11 24.02-18.24 43.66-29.05 43.66-29.05 12.83 3.97 34.03-4.45 35.51-26.07 1.63-23.73-25.9-37.89-49.03-37.08z";
    if (p == 9) return "M124.95 102.08c-35.28 27.05 44.44 98.6 112.51 42.98 11.16-9.12 17.21-15.03 20.06-19.24 2.9-4.29 2.73-9.99-.53-14.01-11.13-13.74-39.84 14.48-66.7 8.8-32.22-6.82-49.82-30.43-65.34-18.53z";
    if (p == 10) return "M164.05 59.9s14.37-7.76 29.49 1.88c5.95 3.79 11.96 5.09 17.19 5.84";
    if (p == 11) return "M241.91 204.25c-12.27 7.5-28.19 12.6-45.59 12.6-24.61 0-46.26-10.21-58.81-22.96l-48.15 25.64c-10.2 5.42-18.71 13.62-24.24 23.75-6.63 12.14-10.2 28.89 2.61 46.83a9.47 9.47 0 0 0 7.71 3.96H189.4c2.97 0 5.93-.51 8.71-1.55 9.93-3.68 31.1-15.4 39.87-50.01 2.16-8.53.45-22.04 1.27-28.53.55-4.34 1.52-7.47 2.66-9.73z";
    if (p == 12) return "M231.24 251.1c-2.91.86-8.74-10.03-11.58-9.43-2.96.63-3.84 12.95-6.73 13.33-3 .4-7.04-11.28-9.95-11.13-3.02.15-5.87 12.17-8.79 12.07-3.02-.09-5.12-12.27-8.01-12.6-3-.34-7.75 11.06-10.62 10.5-2.96-.58-3.12-12.93-5.93-13.71-2.92-.8-9.35 9.74-12.09 8.76-2.86-1.02-1.21-13.27-3.87-14.43-2.79-1.22-10.63 8.32-13.19 7-2.73-1.41.52-13.34-1.93-14.81-2.67-1.6-11.65 6.87-13.97 5.28-2.63-1.8 2.06-13.26-.1-14.94-2.66-2.08-12.63 5.21-14.52 3.53-3.68-3.27 3.01-9.62 2.61-13.34 0 0-24.71 13.82-24.97 15.12 3.47-1.78 6.52-2.45 8.41-1.17 2.97 2-2.9 13.68-.35 15.9 2.7 2.35 13.04-4.67 15.68-2.58 2.82 2.22-1.57 13.91 1.18 15.86 2.94 2.07 12.46-6.01 15.32-4.24 3.06 1.9.1 14.03 3.06 15.6 3.18 1.69 11.54-7.59 14.61-6.24 3.31 1.45 2.18 13.88 5.34 14.97 3.42 1.18 10.14-9.35 13.39-8.55 3.52.86 4.66 13.28 7.96 13.76 3.6.51 8.13-11.12 11.45-11 3.65.13 7.36 12.03 10.66 11.78 3.67-.28 5.53-12.63 8.75-13.25 3.69-.71 10.04 10 13.07 9.02 3.77-1.21 2.64-13.69 5.33-14.95 3.52-1.65 6.79 1.61 9.74 3.82 2.64-5.3 7.39-21.55 7.56-23.22-2.83 1.07-4.74 12.46-7.52 13.29z";
    if (p == 13) return "M175.35 282.85c-2.93.2-5.65 7.92-8.4 11.22h20.62l.06-.06c-3.71.59-8.73-11.4-12.28-11.16z";
    if (p == 14) return "M154.69 282.26c-3.71-.47-9.5 11.14-12.98 10.34-3.64-.84-3.73-13.84-7.12-14.99-3.53-1.2-11.5 9.04-14.76 7.57-3.4-1.54-1.01-14.32-4.11-16.08-3.26-1.85-12.97 6.76-15.9 4.74-3.11-2.14 1.46-14.32-1.27-16.55-2.96-2.42-13.95 4.49-16.46 2.09-2.83-2.7 3.56-14.04 1.3-16.55-2.77-3.07-14.69 2.07-16.6-.41-.26-.34-1.33.22-1.67.85-6.63 12.14-10.2 28.89 2.61 46.83a9.47 9.47 0 0 0 7.71 3.96h87c-2.68-3.37-4.94-11.44-7.75-11.8z";
    if (p == 15) return "M92.09 280.55c10.01 1.14 11.58 13.35 11.58 13.35h-21.8c-1.44 0-2.71-3.17-3.14-4.55l-.9-2.86s3 .75 7.17-.26c5.51-1.33 6.94-5.69 7.09-5.68z";
    if (p == 16) return "M161.98 290.02c.51 1.6 2.04 2.69 3.66 2.69h22.47c.55 0 .98-.47.92-1.01-.26-2.35-1.8-8.07-10.73-9.09 0 0-.98-.06-1.39-.79-.39-.69-1.19-1.23-1.9-.9-3.24 1.52-10.26 2.84-13.83 1.93a.824.824 0 0 0-1 1.03l1.8 6.14z";
    if (p == 17) return "M257.76 153.51a19.986 19.986 0 0 1-5.74-10.57c-4.71-23.97-27.86-42.17-55.7-42.17-27.85 0-50.99 18.2-55.7 42.17-.79 4.03-2.78 7.72-5.74 10.57-5.62 5.4-8.82 11.61-8.82 18.23 0 20.74 31.46 46.12 70.26 46.12s70.26-25.38 70.26-46.12c0-6.62-3.2-12.83-8.82-18.23z";
    if (p == 18) return "M134.87 153.51s-15.38 17.52-6.54 30.8c16.89 25.39 55.47 33.59 52.09 31.75-2.98-1.62 6.04-17.4 2.98-19.44-2.81-1.87-17.96 7.28-20.72 5.03-2.59-2.1 7.91-15 5.45-17.46-2.33-2.33-18.31 5.13-20.46 2.46-2.05-2.55 10.3-14.47 8.47-17.34-1.74-2.75-18.19 2.75-19.67-.32-1.42-2.93 12.54-13.54 11.41-16.78-1.09-3.1-12.23 4.69-13.01 1.3";
    if (p == 19) return "M258.01 153.51s15.38 17.52 6.54 30.8c-16.89 25.39-56.21 32.93-52.83 31.09 2.98-1.62-5.3-16.74-2.24-18.78 2.81-1.87 17.96 7.28 20.72 5.03 2.59-2.1-7.91-15-5.45-17.46 2.33-2.33 18.31 5.13 20.46 2.46 2.05-2.55-10.3-14.47-8.47-17.34 1.74-2.75 18.19 2.75 19.67-.32 1.42-2.93-12.54-13.54-11.41-16.78 1.1-3.1 12.24 4.69 13.01 1.3";
    if (p == 20) return "M180.99 281.91s-.52 2.83-3.92 3.38";
    if (p == 21) return "M184.22 283.42s-.1 2.69-3.52 4.17";
    if (p == 22) return "M95.42 282.63s.12 2.88-3.08 4.16";
    if (p == 23) return "M98.91 283.39s.5 2.65-2.52 4.84";
    if (p == 24) return "M155.31 184.62c.04-.09.08-.18.11-.27.46-1.33-.14-2.83-1.38-3.48-1.49-.78-3.3-.15-3.99 1.36 0 0 0 .01-.01.01-.33.73-1.02 1.24-1.82 1.29-1.1.06-2.44.35-2.82 1.18-.68 1.51.04 3.3 1.61 3.89 1.32.5 1.93-.32 3.23.22 1.16.48 1.05 1.62 2.29 2.28 1.49.78 3.3.15 3.99-1.36.38-.84-.3-2.04-.99-2.91-.49-.64-.55-1.49-.22-2.21z";
    if (p == 25) return "M234.25 115.09s7.19-16.28 2.72-44.45c-.29-1.84 2-3 3.49-1.88 5.81 4.38 16.54 14.4 19.94 30.7 3.43 16.42.55 31.08-6.22 39.55-3.62 4.52-10.69 2.89-12.58-2.59l-7.35-21.33z";
    if (p == 26) return "M235.98 115.33s4.31-28.56-1.36-46.94c-.55-1.78 2-3 3.49-1.88 5.81 4.38 18.45 16.66 21.86 32.96 3.94 18.85 1.04 34.91-8.06 42.57";
    if (p == 27) return "M242.07 121.85c-.17-.35-.22-.74-.14-1.12.67-3.16 3.69-18.61 1.63-32.18-.18-1.18.2-2.59 1.22-1.96 3.95 2.46 7.51 7.23 9.57 17.7 1.76 8.97-.44 22.06-4.53 27.57-.76 1.02-2.34.87-2.9-.27l-4.85-9.74z";
    if (p == 28) return "M254.35 104.29c-.99-5.05-2.33-8.77-3.9-11.55.74 2.04 1.39 4.43 1.94 7.21 1.76 8.97-.44 22.06-4.53 27.57-.76 1.02-2.34.87-2.9-.27l1.96 4.34c.57 1.14 2.15 1.29 2.9.27 4.08-5.51 6.29-18.6 4.53-27.57z";
    if (p == 29) return "M241.93 120.69c.67-3.29 3.69-19.38 1.63-33.51";
    if (p == 30) return "M158.47 115.09s-7.19-16.28-2.72-44.45c.29-1.84-2-3-3.49-1.88-5.81 4.38-16.54 14.4-19.94 30.7-3.43 16.42-.67 30.72 6.1 39.19 3.62 4.52 10.81 3.25 12.7-2.23l7.35-21.33z";
    if (p == 31) return "M156.74 115.21s-4.31-28.44 1.36-46.82c.55-1.78-2-3-3.49-1.88-5.81 4.38-18.45 16.66-21.86 32.96-3.94 18.85-1.04 34.91 8.06 42.57";
    if (p == 32) return "M150.65 121.85c.17-.35.22-.74.14-1.12-.67-3.16-3.69-18.61-1.63-32.18.18-1.18-.2-2.59-1.22-1.96-3.95 2.46-7.51 7.23-9.57 17.7-1.76 8.97.44 22.06 4.53 27.57.76 1.02 2.34.87 2.9-.27l4.85-9.74z";
    if (p == 33) return "M138.37 104.29c.99-5.05 2.33-8.77 3.9-11.55-.74 2.04-1.39 4.43-1.94 7.21-1.76 8.97.44 22.06 4.53 27.57.76 1.02 2.34.87 2.9-.27l-1.96 4.34c-.57 1.14-2.15 1.29-2.9.27-4.09-5.51-6.29-18.6-4.53-27.57z";
    if (p == 34) return "M150.79 120.69c-.67-3.29-3.69-19.38-1.63-33.51";
    if (p == 35) return "M174.77 125.31c-1.7-1.19-3.98-1.12-5.65.12-3.85 2.86-8.35 5.09-13.34 6.45a40.262 40.262 0 0 1-11.66 1.42 4.846 4.846 0 0 0-4.65 3.16c-.88 2.43-1.38 5.04-1.4 7.77-.12 12.92 10.39 23.54 23.31 23.56 12.91.02 23.38-10.44 23.38-23.34 0-7.92-3.95-14.92-9.99-19.14z";
    if (p == 36) return "M174.04 121.71c-5.96 4.43-12.51 12.13-37.13 11.59";
    if (p == 37) return "M184.48 148.03c-2.17-7.02-8.72-12.13-16.46-12.13-9.51 0-17.22 7.71-17.22 17.22 0 6.1 3.17 11.46 7.96 14.52.86.1 1.73.15 2.61.15 11.7.03 21.39-8.55 23.11-19.76z";
    if (p == 38) return "m168.74 135.45-.09.06a6.085 6.085 0 0 0-.92 8.56 6.085 6.085 0 0 0 8.56.92c1.74-1.4 2.5-3.56 2.2-5.62-2.93-2.08-6.28-3.4-9.75-3.92z";
    if (p == 39) return "M219.09 125.31c1.7-1.19 3.98-1.12 5.65.12 3.85 2.86 8.35 5.09 13.34 6.45 3.92 1.07 7.85 1.52 11.66 1.42a4.846 4.846 0 0 1 4.65 3.16c.88 2.43 1.38 5.04 1.4 7.77.12 12.92-10.39 23.54-23.31 23.56-12.91.02-23.38-10.44-23.38-23.34 0-7.92 3.95-14.92 9.99-19.14z";
    if (p == 40) return "M219.81 121.71c5.96 4.43 12.51 12.13 37.13 11.59";
    if (p == 41) return "M209.37 148.03c2.17-7.02 8.72-12.13 16.46-12.13 9.51 0 17.22 7.71 17.22 17.22 0 6.1-3.17 11.46-7.96 14.52-.86.1-1.73.15-2.61.15-11.69.03-21.39-8.55-23.11-19.76z";
    if (p == 42) return "m225.12 135.45.09.06a6.085 6.085 0 0 1 .92 8.56 6.085 6.085 0 0 1-8.56.92 6.073 6.073 0 0 1-2.2-5.62c2.93-2.08 6.28-3.4 9.75-3.92z";
    if (p == 43) return "m190.54 145.12-8.55 13.7c-8.62 14.07 2.84 21.69 2.93 21.78 2.07 1.87 16.83 7.8 25.8-4.36 2.86-3.88 3.04-8.19 1.84-12.55-.75-2.72-10.87-17.46-10.87-17.46-4.25-5.58-8.53-5.24-11.15-1.11z";
    if (p == 44) return "M196 167c.36-1.33 2.16-2.35 3.48-3.57 2.69-2.48 9.25-4.47 6.63-7.45-.86-.98-2.15-1.51-3.49-1.51h-15.39s-5.43 1.99 0 5.42c3.41 2.15 8.61 7.69 8.77 7.11z";
    if (p == 45) return "M189.96 170.38s8.52 6.46 15.76-6.63c0 0 1.32 12.73-12.93 13.17-11.47.36-7.55-8.9-2.83-6.54z";
    if (p == 46) return "M176.69 78.04s3.86 7.76 4.44 16.29c.06.86.85 1.48 1.7 1.31l29.04.03c.83.16 1.62-.44 1.69-1.28.27-3.27 1.07-10.95 3.01-16.88l-1.12.38a35.48 35.48 0 0 0-12.16 7l-.23.35-6.1-11.29-6.57 11.29c-.02-.02-9.33-8.19-13.7-7.2z";
    if (p == 47) return "M198.48 84.06c-.7-1.3-2.56-1.33-3.31-.05l-4.87 8.37s-5.94-5.2-10.55-6.8c.75 2.58 1.4 5.62 1.61 8.76.06.86 32.35.89 32.42.04.16-1.94.5-5.44 1.17-9.2a35.609 35.609 0 0 0-11.75 6.85l-4.72-7.97z";
    if (p == 48) return "M179.3 101.67c-.73-1.88.2-4.83 2.08-5.55 4.83-1.87 9.96-2.82 15.24-2.82 5.28 0 10.41.95 15.24 2.82 1.88.73 2.81 3.68 2.08 5.55-.73 1.88-4.54-1.04-17.32-.97-12.58.07-16.76 2.41-17.32.97z";
    if (p == 49) return "M196.32 217.85s-46.57 48.98-94.6-10.18c0 0 6.84-12.79 20.57-12.09-.01.01 28.62 25.02 74.03 22.27z";
    if (p == 50) return "M101.72 207.68s6.06-12.18 18.98-12.18";
    if (p == 51) return "M96.95 214.2c-2.03-2.46-1.59-6.12.89-8.12 2.49-2 6.12-1.59 8.12.89 13.49 16.83 39.18 37.03 82.7 19.26 7.82-3.19 10.53 1.37 10.53 1.37-.22.22-56.3 42.2-102.24-13.4z";
    if (p == 52) return "M203.39 216.99s5.65 16.78 17.26 20.73c22.11 7.52 31.97 6.89 30.85-.25 0 0 5.51-24.34-10.58-32.22 0 0-8.47 7.79-37.53 11.74z";
    if (p == 53) return "M251.51 237.48s5.51-24.1-10.58-31.98";
    if (p == 54) return "M249.81 245.25c-50.62-3.24-47.98-22-47.98-22 .03.04 25.16 12.66 47.98 12.52 2.47-.02 4.46 2.13 4.46 4.75 0 2.61-2 4.73-4.46 4.73z";
    if (p == 55) return "M253.49 207.46a8.059 8.059 0 0 1-3.66 4.92c-6.56 3.97-24.01 15.44-52.43 10.38 0 0-.58-7.35 6.91-6.62 13.6 1.31 37.08-10.28 43.14-14.61 1.88-1.34 4.63-1.38 6.11 1.83.49 1.07.29 2.66-.07 4.1z";
    if (p == 56) return "M122.28 195.59s23.53 22.27 57.73 29.06c8.99 1.78 14.64-1.74 15.24-2 0 0 .79-6.91-4.24-7.1-38.25-1.49-50.88-23.95-56.94-28.28-1.88-1.34-4.86-3.57-9.31 1.07-1.81 1.88-4.35 5.9-2.48 7.25z";
    if (p == 57) return "M207.42 222.19c0 5.1-4.13 9.23-9.23 9.23-5.1 0-9.23-4.13-9.23-9.23s4.13-8.1 9.23-8.1c5.1 0 9.23 3 9.23 8.1z";
    return "";
  }
}