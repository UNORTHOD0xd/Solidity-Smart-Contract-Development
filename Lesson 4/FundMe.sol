// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier 

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

uint256 public constant minimumUsd = 5;


contract FundMe {
    function fund() public payable {
        //Allow users to send $
        // Have a minimum $ sent
        require(msg.value > 1e18, "Didn't send enough ETH"); // 1e18 = 1ETH = 100000000000000000 wei
    }

    function getPrice() public {
        // Address for the Chainlink pricefeed contract 0x694AA1769357215DE4FAC081bf1f309aDC325306 
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // 3000.00000000 correct to 8 decimal places. ETH does not work well with decimals. 
        return uint256(price * 1e10); // 

    }

    function getConversionRate() public {
        
    }
}