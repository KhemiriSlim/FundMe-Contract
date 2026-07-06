// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;
    uint public minimumUsd = 5e18;
    address[] public funders;
    mapping (address funder=> uint256 amountFunded) public addressToAmountFunded;

    address public owner;
    constructor(){
        owner = msg.sender;
    }


    function fund() public payable{
        require(msg.value.getConvertionRate() >= minimumUsd, "didn t send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
    function withdraw() public onlyOwner{
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder =  funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        //payable (msg.sender).transfer(address(this).balance);
        (bool callsuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callsuccess,"Call failed");
    }
    modifier onlyOwner(){
        require(msg.sender == owner,"Sender is not owner!");
        _;//complete excution the function
    }
}