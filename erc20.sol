// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 编译器版本声明：使用Solidity 0.8.0及以上版本
contract SimpleERC20 {
    string public name = "SimpleToken";// 代币名称
    string public symbol = "SIM";// 代币符号
    uint8 public decimals = 18;// 代币小数位数
    uint256 public totalSupply;// 代币总供应量
    address public owner;// 合约拥有者地址
    mapping(address => uint256) private _balances;// 地址余额映射
    mapping(address => mapping(address => uint256)) private _allowances;// 地址授权映射
    event Transfer(address indexed from, address indexed to, uint256 value);// 转账事件
    event Approval(address indexed owner, address indexed spender, uint256 value);// 授权事件
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    constructor() {
        owner = msg.sender;
    }
    function balanceOf(address account) public view returns (uint256) { // 查询账户余额
        return _balances[account];
    }
    function transfer(address to, uint256 amount) public returns (bool) {// 转账
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    function approve(address spender, uint256 amount) public returns (bool) {// 授权
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {// 授权转账
        require(_balances[from] >= amount, "Insufficient balance");
        require(_allowances[from][msg.sender] >= amount, "Allowance exceeded");
        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
    function allowance(address owner_, address spender) public view returns (uint256) {// 查询授权额度
        return _allowances[owner_][spender];
    }
    function mint(address to, uint256 amount) public onlyOwner {// 铸造新代币
        _balances[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }
}