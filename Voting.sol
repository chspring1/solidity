// SPDX-License-Identifier: MIT
// SPDX许可证标识符：MIT开源许可证

pragma solidity ^0.8.0;
// 编译器版本声明：使用0.8.0以上版本，包含自动溢出检查等安全特性

/**
 * @title Voting - 去中心化投票合约
 * @dev 实现一个功能完整的投票系统
 * 
 * 主要功能：
 * - 存储候选人得票数
 * - 支持用户投票
 * - 查询候选人得票数
 * - 重置所有投票数据
 * - 防止重复投票
 * - 候选人管理
 */
contract Voting {
    // ============ 状态变量 (State Variables) ============
    
    // 合约所有者地址
    address public owner;
    
    // 投票是否开启
    bool public votingActive;
    
    // 候选人得票数映射
    // 键：候选人名称(string) 值：得票数(uint256)
    mapping(string => uint256) public votes;
    
    // 记录地址是否已投票，防止重复投票
    mapping(address => bool) public hasVoted;
    
    // 记录每个地址投票给了哪个候选人
    mapping(address => string) public voterChoice;
    
    // 候选人列表数组，用于遍历所有候选人
    string[] public candidates;
    
    // 检查候选人是否存在的映射
    mapping(string => bool) public candidateExists;
    
    // ============ 事件 (Events) ============
    
    // 投票事件
    event VoteCast(address indexed voter, string candidate, uint256 newVoteCount);
    
    // 候选人添加事件
    event CandidateAdded(string candidate);
    
    // 投票重置事件
    event VotesReset(address indexed admin);
    
    // 投票状态改变事件
    event VotingStatusChanged(bool active);
    
    // ============ 修饰符 (Modifiers) ============
    
    // 只有合约所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 只有在投票开启时可以调用
    modifier whenVotingActive() {
        require(votingActive, "Voting is not active");
        _;
    }
    
    // 检查候选人是否存在
    modifier candidateExists_(string memory candidate) {
        require(candidateExists[candidate], "Candidate does not exist");
        _;
    }
    
    // ============ 构造函数 (Constructor) ============
    
    /**
     * @dev 构造函数，设置合约部署者为所有者
     */
    constructor() {
        owner = msg.sender;
        votingActive = true; // 默认投票开启
    }
    
    // ============ 核心功能函数 ============
    
    /**
     * @dev 添加候选人
     * @param candidate 候选人名称
     * 
     * 功能说明：
     * - 只有合约所有者可以添加候选人
     * - 防止重复添加相同候选人
     * - 自动初始化候选人得票数为0
     */
    function addCandidate(string memory candidate) public onlyOwner {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        require(!candidateExists[candidate], "Candidate already exists");
        
        candidates.push(candidate);
        candidateExists[candidate] = true;
        votes[candidate] = 0; // 初始化得票数为0
        
        emit CandidateAdded(candidate);
    }
    
    /**
     * @dev 投票功能 - 为指定候选人投票
     * @param candidate 候选人名称
     * 
     * 功能详解：
     * - 检查投票是否开启
     * - 检查候选人是否存在
     * - 防止重复投票
     * - 记录投票者的选择
     * - 增加候选人得票数
     * - 触发投票事件
     */
    function vote(string memory candidate) 
        public 
        whenVotingActive 
        candidateExists_(candidate) 
    {
        require(!hasVoted[msg.sender], "You have already voted");
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        
        // 记录投票状态
        hasVoted[msg.sender] = true;
        voterChoice[msg.sender] = candidate;
        
        // 增加候选人得票数
        votes[candidate]++;
        
        // 触发投票事件
        emit VoteCast(msg.sender, candidate, votes[candidate]);
    }
    
    /**
     * @dev 查询候选人得票数
     * @param candidate 候选人名称
     * @return 候选人的得票数
     * 
     * 功能说明：
     * - 公开的查询函数
     * - 检查候选人是否存在
     * - 返回实时得票数
     */
    function getVotes(string memory candidate) 
        public 
        view 
        candidateExists_(candidate) 
        returns (uint256) 
    {
        return votes[candidate];
    }
    
    /**
     * @dev 重置所有候选人的得票数
     * 
     * 功能详解：
     * - 只有合约所有者可以调用
     * - 清空所有候选人的得票数
     * - 触发重置事件
     * 注意：无法重置投票者状态，这是mapping的限制
     */
    function resetVotes() public onlyOwner {
        // 重置所有候选人得票数
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
        
        emit VotesReset(msg.sender);
    }
    
    // ============ 查询功能函数 ============
    
    /**
     * @dev 获取所有候选人列表
     * @return 候选人名称数组
     */
    function getAllCandidates() public view returns (string[] memory) {
        return candidates;
    }
    
    /**
     * @dev 获取候选人总数
     * @return 候选人数量
     */
    function getCandidateCount() public view returns (uint256) {
        return candidates.length;
    }
    
    /**
     * @dev 检查地址是否已投票
     * @param voter 投票者地址
     * @return 是否已投票
     */
    function hasUserVoted(address voter) public view returns (bool) {
        return hasVoted[voter];
    }
    
    /**
     * @dev 查询投票者投票给了哪个候选人
     * @param voter 投票者地址
     * @return 候选人名称
     */
    function getVoterChoice(address voter) public view returns (string memory) {
        require(hasVoted[voter], "This address has not voted yet");
        return voterChoice[voter];
    }
    
    /**
     * @dev 获取总投票数
     * @return 总投票数
     */
    function getTotalVotes() public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            total += votes[candidates[i]];
        }
        return total;
    }

    /**
     * @dev 获取获胜者（得票最多的候选人）
     * @return winnerName 获胜者名称
     * @return winnerVotes 获胜者得票数
     */
    function getWinner() public view returns (string memory winnerName, uint256 winnerVotes) {
        require(candidates.length > 0, "No candidates available");
        
        winnerName = candidates[0];
        winnerVotes = votes[candidates[0]];
        
        for (uint256 i = 1; i < candidates.length; i++) {
            if (votes[candidates[i]] > winnerVotes) {
                winnerName = candidates[i];
                winnerVotes = votes[candidates[i]];
            }
        }
    }
    
    // ============ 管理功能函数 ============
    
    /**
     * @dev 切换投票状态（开启/关闭）
     * @param active 投票状态
     */
    function setVotingStatus(bool active) public onlyOwner {
        votingActive = active;
        emit VotingStatusChanged(active);
    }
    
    /**
     * @dev 转移合约所有权
     * @param newOwner 新所有者地址
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
    }
}

