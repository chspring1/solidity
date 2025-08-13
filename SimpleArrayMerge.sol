// SPDX-License-Identifier: MIT
// SPDX许可证标识符：MIT开源许可证
// 用途：明确代码的许可证类型，避免版权纠纷

pragma solidity ^0.8.0;
// 编译器版本声明：指定Solidity编译器版本
// ^0.8.0：兼容0.8.0及以上版本，但不包括0.9.0
// 版本选择原因：0.8.0引入了重要的安全改进（如自动溢出检查）

/**
 * @title 简单数组合并
 * @dev 将两个有序数组合并为一个有序数组
 * 
 * 功能说明：
 * - 实现经典的归并排序算法中的合并步骤
 * - 输入两个已排序的数组，输出一个合并且排序的数组
 * - 使用双指针技术，时间复杂度为O(n+m)
 * - 空间复杂度为O(n+m)，其中n和m分别是两个数组的长度
 */
contract SimpleArrayMerge {
    
    /**
     * @dev 合并两个升序数组
     * @param arr1 第一个升序排列的数组
     * @param arr2 第二个升序排列的数组
     * @return 合并后的升序数组
     * 
     * 算法原理：
     * 1. 使用三个指针分别指向两个输入数组和结果数组
     * 2. 比较两个输入数组当前指针位置的元素
     * 3. 将较小的元素放入结果数组，并移动对应指针
     * 4. 处理任一数组遍历完成后的剩余元素
     * 
     * 时间复杂度：O(n + m)
     * 空间复杂度：O(n + m)
     */
    function merge(uint[] memory arr1, uint[] memory arr2) 
        public 
        pure 
        returns (uint[] memory) 
    {
        // 创建结果数组，长度为两个输入数组长度之和
        // new uint[]()：动态创建指定长度的数组
        uint[] memory result = new uint[](arr1.length + arr2.length);
        
        // 初始化三个指针变量
        uint i = 0; // arr1的当前索引指针
        uint j = 0; // arr2的当前索引指针  
        uint k = 0; // result的当前索引指针

        // 主要合并逻辑：当两个数组都还有元素时进行比较
        // 条件：i < arr1.length && j < arr2.length
        // 确保两个指针都没有超出各自数组的边界
        while (i < arr1.length && j < arr2.length) {
            // 比较两个数组当前位置的元素大小
            if (arr1[i] < arr2[j]) {
                // arr1当前元素较小，将其放入结果数组
                result[k] = arr1[i];
                i++; // arr1指针向前移动一位
            } else {
                // arr2当前元素较小或相等，将其放入结果数组
                // 注意：相等时选择arr2的元素（保持稳定性）
                result[k] = arr2[j];
                j++; // arr2指针向前移动一位
            }
            k++; // 结果数组指针向前移动一位
        }

        // 处理arr1的剩余元素
        // 当arr2已经遍历完，但arr1还有剩余元素时执行
        while (i < arr1.length) {
            result[k] = arr1[i]; // 直接复制arr1的剩余元素
            i++; // arr1指针前移
            k++; // 结果指针前移
        }

        // 处理arr2的剩余元素  
        // 当arr1已经遍历完，但arr2还有剩余元素时执行
        while (j < arr2.length) {
            result[k] = arr2[j]; // 直接复制arr2的剩余元素
            j++; // arr2指针前移
            k++; // 结果指针前移
        }

        // 返回合并完成的结果数组
        return result;
    }
    // 函数特点说明：
    // - public：外部和内部都可以调用此函数
    // - pure：纯函数，不读取也不修改合约状态，只基于输入参数计算
    // - memory：参数和返回值都存储在内存中（临时存储）
    // - 函数执行完毕后，内存中的数据会被清理
}