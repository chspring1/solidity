<<<<<<< HEAD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch{
 function binarySearch (uint[]memory arr, uint target) public pure returns (int){
   int left =0;
   int right = int(arr.length)-1;
    while (left < right){
   int mid = left+ (right-left)/2;
    if (arr[uint(mid)]==target){
        return mid;
    }else if (arr[uint(mid)]<target){
        left =mid +1;
    }else {
        right =mid -1;
    }

    }
    return -1;

 }

}

=======
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch{
 function binarySearch (uint[]memory arr, uint target) public pure returns (int){
   int left =0;
   int right = int(arr.length)-1;
    while (left < right){
   int mid = left+ (right-left)/2;
    if (arr[uint(mid)]==target){
        return mid;
    }else if (arr[uint(mid)]<target){
        left =mid +1;
    }else {
        right =mid -1;
    }

    }
    return -1;

 }

}

>>>>>>> de5ebd821bf1712b4f43faafcaaf6eb22afec785
