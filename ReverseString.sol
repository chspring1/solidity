// SPDX-License-Identifier: MIT
// MIT许可证标识符：表示此代码使用MIT开源许可证

pragma solidity ^0.8.0;
// 编译器版本声明：使用Solidity 0.8.0及以上版本

contract ReverseString {
    // 定义一个名为ReverseString的智能合约
    
    function reverseString() public pure returns (string memory) {
        // 定义一个公开的纯函数，返回内存中的字符串
        // public: 外部和内部都可以调用
        // pure: 不读取也不修改合约状态的纯函数
        // returns (string memory): 返回存储在内存中的字符串
        
        string memory input = "Hello, World!";
        // 在内存中创建一个字符串变量，存储要反转的文本
        // memory: 数据存储在临时内存中，函数结束后释放
        
        bytes memory inputBytes = bytes(input);
        // 将字符串转换为字节数组，因为字符串不支持直接索引访问
        // bytes(): 类型转换函数，将string转为可操作的字节数组
        
        bytes memory reversedBytes = new bytes(inputBytes.length);
        // 创建一个新的字节数组，长度与原字符串相同
        // new bytes(): 动态创建指定长度的字节数组
        // inputBytes.length: 获取原字符串的字节长度
        
        for (uint i = 0; i < inputBytes.length; i++) {
            // 使用for循环遍历原字符串的每个字节
            // uint i = 0: 初始化循环变量为0
            // i < inputBytes.length: 循环条件，确保不超出数组边界
            // i++: 每次循环后i自增1
            
            reversedBytes[i] = inputBytes[inputBytes.length - 1 - i];
            // 将原字符串的字节按相反顺序复制到新数组
            // reversedBytes[i]: 新数组的第i个位置
            // inputBytes.length - 1 - i: 原数组的倒数第(i+1)个位置
            // 实现字符串反转的核心逻辑
        }

        string memory result = string(reversedBytes);
        // 将反转后的字节数组转换回字符串类型
        // string(): 类型转换函数，将bytes转为string
        // result: 存储最终反转结果的变量名，避免与函数名冲突
        
        // 返回反转后的字符串
        return result;
        // 将反转后的字符串返回给函数调用者
    }
}



