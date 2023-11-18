// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract AccessRestriction {
    
    address public owner = msg.sender;
   
    uint public creationTime = block.timestamp;

    
    error Unauthorized(); 
    error TooEarly(); 
    error NotEnoughEther(); 

    
    modifier onlyBy(address account) {
        if (msg.sender != account)
            revert Unauthorized();
        _; 
    }


    function changeOwner(address newOwner)
        public
        onlyBy(owner)
    {
        owner = newOwner;
    }


    modifier onlyAfter(uint time) {
        if (block.timestamp < time)
            revert TooEarly();
        _;
    }


    function disown()
        public
        onlyBy(owner)
        onlyAfter(creationTime + 6 weeks)
    {
        delete owner;
    }


    modifier costs(uint amount) {
        if (msg.value < amount)
            revert NotEnoughEther();

        _;

        
        if (msg.value > amount)
            payable(msg.sender).transfer(msg.value - amount);
    }

    
    function forceOwnerChange(address newOwner)
        public
        payable
        costs(200 ether)
    {
        owner = newOwner;

    
        if (uint160(owner) & 0 == 1)
            return; 
    }
}
