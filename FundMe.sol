// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{
    uint public minimumUsd = 5e18;
    address[] public funders;
    mapping (address funder=> uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable{
        require(getConvertionRate(msg.value) >= minimumUsd, "didn t send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
    function getPrice () public view returns(uint256){
        //Adress  0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( , int256 price , , ,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }
    function getConvertionRate(uint256 ehtAmount) public view returns (uint256){
        uint ethPrice = getPrice();
        uint256 ethAmountUsd = (ethPrice * ehtAmount) / 1e18;
        return ethAmountUsd;
    }
    function getVersion() public view returns (uint256){
        return  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}