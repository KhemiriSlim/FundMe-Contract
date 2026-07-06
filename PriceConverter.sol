// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice () internal  view returns(uint256){
        //Adress  0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( , int256 price , , ,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }
    function getConvertionRate(uint256 ehtAmount) internal view returns (uint256){
        uint ethPrice = getPrice();
        uint256 ethAmountUsd = (ethPrice * ehtAmount) / 1e18;
        return ethAmountUsd;
    }
    function getVersion() internal view returns (uint256){
        return  AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}