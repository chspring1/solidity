// SPDX-License-Identifier: MIT
// MIT许可证标识符：表示此代码使用MIT开源许可证

pragma solidity ^0.8.0;
// 编译器版本声明：使用Solidity 0.8.0及以上版本

contract IntegerToRoman {
    // 定义一个将整数转换为罗马数字的智能合约
    
    // 定义罗马数字对应的整数值（从大到小排列）
    uint[] private values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    // values数组：存储所有可能的罗马数字组合对应的数值
    // 包括特殊组合：900(CM), 400(CD), 90(XC), 40(XL), 9(IX), 4(IV)
    
    // 定义对应的罗马数字字符串
    string[] private numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    // numerals数组：存储对应的罗马数字字符串表示
    // M=1000, CM=900, D=500, CD=400, C=100, XC=90, L=50, XL=40, X=10, IX=9, V=5, IV=4, I=1
    
    /**
     * @dev 将整数转换为罗马数字字符串
     * @param num 要转换的整数（范围：1-3999）
     * @return 对应的罗马数字字符串
     */
    function intToRoman(uint num) public view returns (string memory) {
        // 公开的视图函数：接受整数参数，返回罗马数字字符串
        // view: 只读函数，不修改合约状态
        // uint num: 输入的整数参数
        // returns (string memory): 返回内存中的字符串
        
        require(num > 0 && num <= 3999, "Number must be between 1 and 3999");
        // 输入验证：确保数字在有效范围内
        // 罗马数字传统上只表示1到3999的数字
        // require: 如果条件不满足会抛出异常并回滚交易
        
        string memory result = "";
        // 初始化结果字符串为空
        // memory: 数据存储在临时内存中
        
        // 遍历所有的罗马数字值（从大到小）
        for (uint i = 0; i < values.length; i++) {
            // for循环：遍历values数组中的每个元素
            // i < values.length: 循环条件，确保不超出数组边界
            
            // 计算当前值能被使用多少次
            uint count = num / values[i];
            // count: 当前罗马数字值在输入数字中出现的次数
            // num / values[i]: 整数除法，得到商（次数）
            
            // 如果count大于0，说明需要添加对应的罗马数字
            if (count > 0) {
                // 将对应的罗马数字添加count次到结果中
                for (uint j = 0; j < count; j++) {
                    // 内层循环：重复添加当前罗马数字字符
                    result = string(abi.encodePacked(result, numerals[i]));
                    // abi.encodePacked: 将多个参数打包连接
                    // string(): 将打包后的字节转换为字符串
                    // 实现字符串拼接功能
                }
                
                // 从num中减去已经处理的部分
                num = num % values[i];
                // 取模运算：获取除法的余数，继续处理剩余部分
            }
        }
        
        return result;
        // 返回完整的罗马数字字符串
    }
    
    /**
     * @dev 批量转换多个整数为罗马数字
     * @param numbers 要转换的整数数组
     * @return 对应的罗马数字字符串数组
     */
    function batchIntToRoman(uint[] memory numbers) public view returns (string[] memory) {
        // 批量转换函数：接受整数数组，返回罗马数字字符串数组
        // uint[] memory numbers: 输入的整数数组
        // returns (string[] memory): 返回字符串数组
        
        string[] memory results = new string[](numbers.length);
        // 创建与输入数组长度相同的结果数组
        // new string[]: 动态创建字符串数组
        // numbers.length: 获取输入数组的长度
        
        for (uint i = 0; i < numbers.length; i++) {
            // 遍历输入数组中的每个数字
            results[i] = intToRoman(numbers[i]);
            // 调用单个转换函数，将结果存储在对应位置
        }
        
        return results;
        // 返回完整的结果数组
    }
    
    /**
     * @dev 获取预定义的测试用例
     * @return 包含测试数字和对应罗马数字的结果
     */
    function getTestCases() public view returns (uint[] memory, string[] memory) {
        // 测试用例函数：返回预定义的测试数据
        // returns (uint[] memory, string[] memory): 返回两个数组
        
        uint[] memory testNumbers = new uint[](10);
        // 创建测试数字数组
        testNumbers[0] = 1;     // I
        testNumbers[1] = 4;     // IV  
        testNumbers[2] = 9;     // IX
        testNumbers[3] = 27;    // XXVII
        testNumbers[4] = 58;    // LVIII
        testNumbers[5] = 94;    // XCIV
        testNumbers[6] = 246;   // CCXLVI
        testNumbers[7] = 421;   // CDXXI
        testNumbers[8] = 1994;  // MCMXCIV
        testNumbers[9] = 3999;  // MMMCMXCIX
        
        string[] memory expectedResults = batchIntToRoman(testNumbers);
        // 调用批量转换函数获取对应的罗马数字
        
        return (testNumbers, expectedResults);
        // 返回测试数字和对应的罗马数字结果
    }
    
    /**
     * @dev 验证罗马数字转换的正确性
     * @param num 要验证的数字
     * @param expected 期望的罗马数字结果
     * @return 转换结果是否正确
     */
    function verifyConversion(uint num, string memory expected) public view returns (bool) {
        // 验证函数：检查转换结果是否正确
        // string memory expected: 期望的罗马数字字符串
        // returns (bool): 返回布尔值表示是否正确
        
        string memory actual = intToRoman(num);
        // 获取实际的转换结果
        
        return keccak256(abi.encodePacked(actual)) == keccak256(abi.encodePacked(expected));
        // 字符串比较：通过哈希值比较两个字符串是否相等
        // keccak256: 计算输入的哈希值
        // abi.encodePacked: 将字符串编码为字节
    }
}
