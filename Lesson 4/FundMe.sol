// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier 

pragma solidity ^0.8.19;

uint256 public minimumUsd = 5;

contract FundMe {
    function fund() public payable {
        //Allow users to send $
        // Have a minimum $ sent
        require(msg.value > 1e18, "Didn't send enough ETH"); // 1e18 = 1ETH = 100000000000000000 wei
    }
}