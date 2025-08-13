// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {

// 在合约中添加如下函数
function binarySearch(uint[] memory arr, uint target) public pure returns (int) {
    int left = 0;
    int right = int(arr.length) - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[uint(mid)] == target) {
            return mid; // 找到目标，返回索引
        } else if (arr[uint(mid)] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1; // 未找到，返回-1
}
}