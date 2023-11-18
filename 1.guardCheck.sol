// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract GuardCheck {
    function donate(address addr) public payable {
        require(addr != address(0), "Invalid address");
        require(msg.value != 0, "Send more than zero value");

        uint256 balanceBeforeTransfer = this.balance;
        uint256 transferAmount;

        if (addr.balance == 0) {
            transferAmount = msg.value;
        } else if (addr.balance < msg.sender.balance) {
            transferAmount = msg.value / 2;
        } else {
            revert("Invalid conditions");
        }

        addr.transfer(transferAmount);

        assert(
            this.balance == balanceBeforeTransfer - transferAmount,
            "The balance is different"
        );
    }
}