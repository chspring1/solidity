# Solidity 基本语法思维导图

## 🏗️ HelloSolidity 合约结构

```
HelloSolidity 合约
├── 📋 合约头部
│   ├── SPDX-License-Identifier: MIT
│   ├── pragma solidity ^0.8.0
│   └── 合约文档注释
│
├── 🔢 状态变量 (State Variables)
│   ├── 基本数据类型
│   │   ├── string message - 动态字符串，UTF-8编码
│   │   ├── address owner - 20字节地址，支持转账
│   │   ├── uint256 count - 256位无符号整数
│   │   └── bool isActive - 布尔值，true/false
│   │
│   ├── 整数类型变种
│   │   ├── uint8 smallNumber - 8位整数(0-255)
│   │   ├── uint128 mediumNumber - 128位整数
│   │   └── int256 signedNumber - 有符号整数
│   │
│   └── 字节类型
│       ├── bytes32 fixedBytes - 固定32字节
│       ├── bytes1 singleByte - 单字节
│       └── bytes dynamicBytes - 动态字节数组
│
├── 🗺️ 映射 (Mappings)
│   ├── 基本映射
│   │   ├── mapping(address => uint256) balances
│   │   └── mapping(address => bool) authorized
│   │
│   ├── 嵌套映射
│   │   └── mapping(address => mapping(uint256 => bool)) nestedMapping
│   │
│   └── 映射到结构体
│       └── mapping(address => Person) personData
│
├── 📊 数组 (Arrays)
│   ├── 动态数组
│   │   ├── uint256[] numbers - 数字数组
│   │   └── address[] users - 地址数组
│   │
│   ├── 固定长度数组
│   │   └── uint256[5] fixedArray - 5元素数组
│   │
│   ├── 多维数组
│   │   └── uint256[][] matrix - 二维数组
│   │
│   └── 字节数组
│       └── bytes32[] hashList - 哈希列表
│
├── 🏢 结构体 (Structs)
│   ├── Person 结构体
│   │   ├── string name - 姓名
│   │   ├── uint256 age - 年龄
│   │   ├── bool isRegistered - 注册状态
│   │   ├── address wallet - 钱包地址
│   │   └── uint8 level - 等级
│   │
│   └── Company 结构体（嵌套）
│       ├── string companyName - 公司名
│       ├── Person[] employees - 员工数组
│       ├── mapping(address => bool) isEmployee - 员工映射
│       └── uint256 foundedYear - 成立年份
│
├── 🏷️ 枚举 (Enums)
│   ├── Status 枚举
│   │   ├── Pending (0) - 待定
│   │   ├── Active (1) - 活跃
│   │   └── Inactive (2) - 非活跃
│   │
│   ├── Priority 枚举
│   │   ├── Low (0) - 低优先级
│   │   ├── Medium (1) - 中等优先级
│   │   ├── High (2) - 高优先级
│   │   └── Critical (3) - 紧急
│   │
│   └── UserRole 枚举
│       ├── Guest (0) - 访客
│       ├── User (1) - 用户
│       ├── Admin (2) - 管理员
│       └── SuperAdmin (3) - 超级管理员
│
├── 📝 事件 (Events)
│   ├── MessageChanged - 消息更改事件
│   │   ├── string oldMessage
│   │   └── string newMessage
│   │
│   └── UserAdded - 用户添加事件
│       ├── address indexed user (可过滤)
│       └── uint256 timestamp
│
├── 🔒 修饰符 (Modifiers)
│   ├── onlyOwner() - 仅所有者
│   │   ├── require(msg.sender == owner)
│   │   └── 权限控制
│   │
│   └── whenActive() - 仅激活时
│       ├── require(isActive)
│       └── 状态控制
│
├── 🏗️ 构造函数 (Constructor)
│   ├── 部署时执行一次
│   ├── 初始化状态变量
│   ├── 设置合约所有者
│   └── 初始化基本数据类型
│
├── 🔧 公共函数 (Public Functions)
│   ├── 状态修改函数
│   │   ├── setMessage() - 设置消息
│   │   ├── incrementCount() - 增加计数
│   │   ├── addBalance() - 添加余额
│   │   ├── addNumber() - 添加数字
│   │   ├── toggleActive() - 切换状态
│   │   └── changeStatus() - 更改状态
│   │
│   ├── 查询函数 (view)
│   │   ├── getMessage() - 获取消息
│   │   ├── getBalance() - 获取余额
│   │   ├── getNumbersLength() - 获取数组长度
│   │   └── getContractBalance() - 获取合约余额
│   │
│   └── 纯函数 (pure)
│       └── createPerson() - 创建Person结构体
│
├── 🛠️ 数据结构操作函数
│   ├── setBasicTypes() - 设置基本类型
│   ├── setBytesData() - 设置字节数据
│   ├── setFixedArrayValue() - 设置固定数组值
│   ├── addMatrixRow() - 添加矩阵行
│   ├── setNestedMapping() - 设置嵌套映射
│   ├── createPersonStruct() - 创建Person结构体
│   └── setEnumValues() - 设置枚举值
│
├── 💰 支付相关函数
│   ├── deposit() - 存款函数 (payable)
│   │   ├── 接收以太币
│   │   ├── msg.value 获取金额
│   │   └── 更新用户余额
│   │
│   └── withdraw() - 提取函数
│       ├── 余额检查
│       ├── 安全转账
│       └── 防重入攻击
│
└── 🎯 特殊函数
    ├── receive() - 接收函数
    │   ├── external payable
    │   ├── 自动触发
    │   └── gas限制2300
    │
    └── destroy() - 销毁函数
        ├── selfdestruct()
        ├── 转移余额
        └── 不可逆操作
```

## 📊 数据类型特性对比

| 类型 | 大小 | 范围 | Gas消耗 | 打包特性 |
|------|------|------|---------|----------|
| bool | 1字节 | true/false | 低 | 可打包 |
| uint8 | 1字节 | 0-255 | 低 | 可打包 |
| uint128 | 16字节 | 0-2^128-1 | 中 | 两个可共享槽 |
| uint256 | 32字节 | 0-2^256-1 | 中 | 占满一个槽 |
| address | 20字节 | 以太坊地址 | 中 | 可与小类型打包 |
| bytes32 | 32字节 | 固定32字节 | 中 | 占满一个槽 |
| string | 变长 | UTF-8字符串 | 高 | 单独存储 |
| bytes | 变长 | 动态字节 | 高 | 单独存储 |

## 🎨 函数类型特性

```
函数类型
├── 状态可变性
│   ├── pure - 不读不写状态
│   ├── view - 只读状态
│   ├── 无修饰符 - 可读写状态
│   └── payable - 可接收以太币
│
├── 可见性
│   ├── public - 内外部都可调用
│   ├── external - 只能外部调用
│   ├── internal - 内部和继承可调用
│   └── private - 只能内部调用
│
└── 修饰符
    ├── onlyOwner - 权限控制
    ├── whenActive - 状态控制
    └── 自定义修饰符 - 条件检查
```

## 🔄 Gas 消耗模式

```
Gas 消耗等级
├── 免费 (本地调用)
│   ├── view 函数
│   ├── pure 函数
│   └── constant 查询
│
├── 低消耗
│   ├── 读取storage
│   ├── 基本运算
│   └── 事件记录
│
├── 中等消耗
│   ├── 写入storage
│   ├── mapping操作
│   └── 数组push
│
└── 高消耗
    ├── 合约创建
    ├── 大数组操作
    └── 复杂计算
```

## 🛡️ 安全模式

```
安全最佳实践
├── 检查-效果-交互模式
│   ├── 1. 条件检查 (require)
│   ├── 2. 状态修改
│   └── 3. 外部调用
│
├── 权限控制
│   ├── onlyOwner 修饰符
│   ├── 角色管理
│   └── 多重签名
│
├── 溢出保护
│   ├── Solidity 0.8+ 自动检查
│   ├── SafeMath 库
│   └── 边界验证
│
└── 重入攻击防护
    ├── 先修改状态
    ├── 后执行转账
    └── ReentrancyGuard
```

这个思维导图涵盖了您的 Solidity 合约中的所有主要概念和特性，可以作为学习和参考的完整指南！
