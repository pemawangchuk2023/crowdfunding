Web3 Crowdfunding Project

Description

This project implements a crowdfunding smart contract on the Sepolia Testnet. The contract allows users to create and contribute to crowdfunding campaigns in a decentralized manner, leveraging the Ethereum blockchain.

Features

Smart contract deployment on Sepolia Testnet
Functions for creating and managing crowdfunding campaigns
Integration with Ethereum wallets for transactions
Prerequisites

Before you begin, ensure you have met the following requirements:

Node.js installed
Ethereum wallet (e.g., MetaMask) with Sepolia Testnet configured
Installation

Clone the repository and install dependencies:

bash
Copy code
git clone https://github.com/pemawangchuk2023/crowdfunding/tree/main
cd https://github.com/pemawangchuk2023/crowdfunding/tree/main
npm install
Configuration

Create a .env file in the root directory and add your Ethereum wallet private key and Sepolia Testnet RPC URL:

makefile
Copy code
PRIVATE_KEY=your_private_key
RPC_URL=your_rpc_url
Usage

To deploy the smart contract to the Sepolia Testnet, run:

bash
Copy code
npx hardhat run scripts/deploy.js --network sepolia
Testing

Run tests with the following command:

bash
Copy code
npx hardhat test
Contributing

Contributions are welcome! Please follow these steps:

Fork the repository
Create a new branch: git checkout -b <branch_name>
Make your changes and commit them: git commit -am 'Add some feature'
Push to the original branch: git push origin [project_name]/[location]
Create the pull request
Alternatively, see the GitHub documentation on creating a pull request.

