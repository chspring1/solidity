pragma solidity ^0.8.0;

contract ArrayMerger {
    function mergeArrays(uint[] memory array1, uint[] memory array2) public pure returns (uint[] memory) {
        uint[] memory mergedArray = new uint[](array1.length + array2.length);
        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (i < array1.length && j < array2.length) {
            if (array1[i] < array2[j]) {
                mergedArray[k] = array1[i];
                i++;
            } else {
                mergedArray[k] = array2[j];
                j++;
            }
            k++;
        }

        // Copy any remaining elements from either array
        while (i < array1.length) {
            mergedArray[k] = array1[i];
            i++;
            k++;
        }
        while (j < array2.length) {
            mergedArray[k] = array2[j];
            j++;
            k++;
        }

        return mergedArray;
    }
}
