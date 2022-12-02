// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Token {
    uint public _totalSupply = 1000000e15;
    address owner;

    mapping(address => uint) public _balanceOf;
    mapping(address => mapping(address => uint)) public _allowance;

    string public name = "NewToken";
    string public symbol = "NT";
    uint8 public decimal = 18;

    constructor() {
        owner = msg.sender;
        // address that deploys contract will be the owner 
    }

    function blacklist(address _address) external returns(bool) {
        require(owner = msg.sender, "should be owner");
        require(!blacklist[_address], "already blacklisted");
        blacklist[_address] = true;
        return true;
    }

    function totalSupply() external view returns(uint) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns(uint) {
        return _balanceOf[account];
    }

    function transfer(address recipient, uint amount) external returns(bool) {
        require(!blacklist[recipient], "already blacklisted");
        _balanceOf[msg.sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns(uint) {
        return _allowance[owner][spender];
    }

    function mint() public { 
        _balanceOf[msg.sender] = 500e18;
    }    
    
    function approve(address spender, uint amount) external returns(bool) {
        _allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns(bool) {
        _allowance[sender][recipient] -= amount;
        _balanceOf[sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approve(address indexed owner, address indexed spender, uint amount);

}
