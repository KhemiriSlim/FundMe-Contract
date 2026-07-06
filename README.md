# FundMe - Smart Contract Fundraising Platform

A Solidity smart contract that enables users to fund a project with ETH while ensuring a minimum USD contribution ($5) using Chainlink price feeds. Only the contract owner can withdraw all accumulated funds.

## Features
- 💰 Accept ETH donations with USD minimum requirement
- 🔗 Real-time price conversion using Chainlink Oracles
- 👨‍💼 Owner-only withdrawal mechanism
- 📊 Track all funder contributions
- 🔐 Secure fund transfer using low-level call

## Tech Stack
- Solidity ^0.8.18
- Chainlink Price Feeds (ETH/USD)
- Remix IDE

## How It Works
Users send ETH → Contract checks if >= $5 USD → Amount recorded → Owner withdraws all funds
