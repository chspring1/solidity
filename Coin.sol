pragma solidity ^0.8.0;
//一个代币的合约
contract Coin{
    address public minter;
    mapping (address => uint) public balances;
    event Sent(address from, address to, uint amount);
    event Transfer(address indexed from, address indexed to, uint256 value);
    constructor() {
        // 构造函数，合约部署时执行
        minter = msg.sender; // 设置合约创建者为minter
    }
    function mint (address receiver, uint amount) public {
       require(msg.sender == minter);
       balances[receiver] += amount; // 增加接收者的余额
        
    }
    function send(address receiver, uint amount) public {
        require(balances[msg.sender] >= amount);
       balances[msg.sender] -= amount; // 减少发送者的余额
       balances[receiver] += amount; // 增加接收者的余额
       emit Sent(msg.sender, receiver, amount); // 发送事件
    }
    
    
}