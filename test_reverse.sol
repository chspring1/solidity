// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ReverseString{
 function reverseString() public pure  returns (string memory){
    string memory input ="abcdef";
    bytes memory inputBytes = bytes(input);
    bytes memory reverseBytes = new  bytes(inputBytes.length);

    for (uint i=0; i < inputBytes.length;i++){
   reverseBytes[i]= inputBytes[inputBytes.length-1-i];

    }
string memory result = string(reverseBytes);

    return  result;

 }

}
