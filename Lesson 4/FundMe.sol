// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier 

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

uint256 public constant minimumUsd = 5e18;

Address[] public funders;
mapping(address funder => uint256 amountFunded) public addressToAmountFunded;


contract FundMe {
    function fund() public payable {
        //Allow users to send $
        // Have a minimum $ sent
        require(getConversionRate (msg.value) >= minimumUsd, "Didn't send enough ETH"); // 1e18 = 1ETH = 100000000000000000 wei
        funders.push(msg.sender); // keeps track of sender addresses in an array
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value; //maps how much a sender spent to this contract
    }

    function getPrice() public {
        // Address for the Chainlink pricefeed contract 0x694AA1769357215DE4FAC081bf1f309aDC325306 
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData(); 
        // Price of ETH in terms of USD
        // 3000.00000000 correct to 8 decimal places. ETH does not work well with decimals. 
        return uint256(price * 1e10); // This function gets the current ETH price denominted in USD correct to 18 decimal places
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    } // This function converts the 

    function getVersion() pubilc view returns (uint256) {
       return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306 ).version();
    }
}