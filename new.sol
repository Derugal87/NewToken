// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract Token {
    uint public _totalSupply = 1000000e15;

    mapping(address => uint) public _balanceOf;
    mapping(address => mapping(address => uint)) public _allowance;
    mapping(address => bool) public _blacklist;

    string public name = "NewToken";
    string public symbol = "NT";
    uint8 public decimal = 18;


    function blacklisted(address _address, address owner) external returns(bool) {
        require(msg.sender == owner, "should be owner");
        require(!_blacklist[_address], "blacklisted");
        _blacklist[_address] = true;
        return true;
    }

    function totalSupply() external view returns(uint) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns(uint) {
        return _balanceOf[account];
    }

    function transfer(address recipient, uint amount) external returns(bool) {
        require(!_blacklist[recipient], "already blacklisted");
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
