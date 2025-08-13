<<<<<<< HEAD
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract RomanToInteger {
   mapping (bytes1 => uint) private romanValues ;
   
   constructor() {
        romanValues["I"] = 1;
        romanValues["V"] = 5;
        romanValues["X"] = 10;
        romanValues["L"] = 50;
        romanValues["C"] = 100;
        romanValues["D"] = 500;
        romanValues["M"] = 1000;
   }
   function romanToInt(string memory roman) public view returns (uint) {
       bytes memory romanBytes = bytes(roman);
       uint total = 0;
       
       for (uint i = 0; i < romanBytes.length; i++) {
           uint value = romanValues[romanBytes[i]];

           if (i + 1 < romanBytes.length && romanValues[romanBytes[i + 1]] > value) {
               total -= value;  // 修正：使用value而不是values
           } else {
               total += value;
           }
       }
       
       return total;  // 修正：使用return而不是returns
   }


=======
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract RomanToInteger {
   mapping (bytes1 => uint) private romanValues ;
   
   constructor() {
        romanValues["I"] = 1;
        romanValues["V"] = 5;
        romanValues["X"] = 10;
        romanValues["L"] = 50;
        romanValues["C"] = 100;
        romanValues["D"] = 500;
        romanValues["M"] = 1000;
   }
   function romanToInt(string memory roman) public view returns (uint) {
       bytes memory romanBytes = bytes(roman);
       uint total = 0;
       
       for (uint i = 0; i < romanBytes.length; i++) {
           uint value = romanValues[romanBytes[i]];

           if (i + 1 < romanBytes.length && romanValues[romanBytes[i + 1]] > value) {
               total -= value;  // 修正：使用value而不是values
           } else {
               total += value;
           }
       }
       
       return total;  // 修正：使用return而不是returns
   }


>>>>>>> de5ebd821bf1712b4f43faafcaaf6eb22afec785
}