// Get funds from users
// Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier 

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

uint256 public constant minimumUsd = 5e18;

Address[] public funders;
mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

address public owner;

constructor() {
    owner = msg.sender;
}


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

    function Withdraw() public {
        // for loop to reset the funders to 
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // There are 3 different methods of sending funds in ether 1.transfer 2.send 3.call
        // payable(msg.sender) = payable address
        // msg.sender = address
        //payable(msg.sender).transfer(address(this).balance); // Transfer uses a max gas of 2300 and reverts the transaction if failed and throws an error.
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed"); // Send also uses a max gas of 2300 but does not rever the transaction if failed, only returns a bool
        // call
       (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
       require(callSuccess, "Call failed"); // call is a low level function used to send funds. 
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Must be contract owner!");
        _;
    }
}