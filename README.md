# Introduction to FootballToken (ERC20)

Welcome to the ```FootballGamingToken``` project, an ```ERC20-compliant``` token designed specifically for a ```football-themed``` gaming experience. This smart contract enables players to ```earn```, ```transfer```, and ```redeem``` tokens for various football-related in-game items.

## Description

### Key Features
#### ➛ ```Minting New Tokens```:
The owner can mint new tokens and distribute them to players who purchase tokens. Players are added to a queue, and tokens are minted and distributed accordingly.  
  
#### ➛ ```Transferring Tokens```:
The platform allows the owner to mint new tokens and distribute them to players as rewards.  
  
#### ➛ ```Redeeming Football Items```:
Players can redeem their tokens for in-game items such as ```footballs```, ```jerseys```, ```shoes```, ```gloves```, and ```whistles```. Each item has a specific token cost, promoting ```strategic``` gameplay.      
  
#### ➛ ```Checking Token Balance```:
Players can check their token balance at any time to keep track of their items and resources.    
  
#### ➛ ```Burning Tokens```:
Players can burn tokens they no longer need, helping to manage the total token supply and maintaining a balanced in-game economy.  

## Getting Started

### Installing

* How/where to download your program
* Any modifications needed to be made to files/folders

### Executing program

#### Prerequisites
➛ ```Remix IDE```: A web-based integrated development environment for Ethereum smart contracts (https://remix.ethereum.org) to access the IDE.
➛ ```MetaMask```: A browser extension wallet for interacting with Ethereum-based applications.

#### Deployment on Remix IDE
1. Open the ```remix ide``` in your web browser.
2. Create a new file in ```Remix IDE```.
3. Compile the contract by selecting the appropriate Solidity compiler version in Remix IDE and clicking the "Compile" button.
4. Connect ```MetaMask``` to Remix IDE by clicking on the MetaMask extension icon in your browser and following the instructions to log in.
5. Deploy the contract by clicking the ```"Deploy & Run Transactions"``` tab in Remix IDE.
6. Click the ```"Deploy"``` button to deploy the contract to the selected testnet.
7. Confirm the transaction in MetaMask and wait for the contract to be deployed. Once deployed, you will see the contract address in the ```Remix IDE```.

#### Connection
1. Go to ```Snowtrace``` website.

2. Copy the contract address from ```Remix IDE``` and paste into the search bar on the ```Snowtrace```.

3. You can now get the informations about the functions.


### CODE
```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20 {
    
    event TokensRedeemed(address indexed player, uint256 amount, string item);

    string[] public availableItems;

    mapping(address => mapping(string => uint256)) public redemptions;

    mapping(string => bool) private itemExists;

    address private _owner;

    constructor(address initialOwner) ERC20("DegenGamingToken", "DGT") {
         _owner = initialOwner;

        availableItems.push("Football");
        availableItems.push("Jersey");
        availableItems.push("Shoes");
        availableItems.push("Gloves");
        availableItems.push("Whistle");

        for (uint256 i = 0; i < availableItems.length; i++) {
            itemExists[availableItems[i]] = true;
        }
    }
    modifier onlyOwner() {
        require(msg.sender == _owner, "Not the owner");
        _;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function redeemTokens(uint256 amount, string memory item) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        require(itemExists[item], "Item not available for redemption");

        _burn(msg.sender, amount);
        redemptions[msg.sender][item] += amount;
        emit TokensRedeemed(msg.sender, amount, item);
    }

    function getTokenBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function getAvailableItems() external view returns (string[] memory) {
        return availableItems;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        return super.transfer(recipient, amount);
    }
}
```


## Help
If you encounter any issues or have questions about this project, there are several resources available to assist you:

### Documentation
```Solidity Documentation```: Comprehensive documentation for the Solidity programming language, including syntax and features. Visit Solidity Documentation.
```Remix Documentation```: Learn how to use Remix, the online Solidity IDE, with detailed guides and examples. Visit Remix Documentation.

### Contact
If you need further assistance, feel free to reach out:

Email: badalrai242@gmail.com  
GitHub Issues: Report issues or suggest enhancements on our GitHub Issues page.  

  
#### Community  
Join the community to discuss the project and get help from other user:
LinekdIn: [@BadalRai](https://www.linkedin.com/in/badal-rai)  
Discord: Join our Discord Server [@NO2](https://discord.gg/Dnw4ZjEg)    
I hope this information helps you get the most out of our Blockchain Message Manager Smart Contract project. If you have any feedback or suggestions, please let us know!

## Authors

Badal Kumar Rai                                                                                                                        
[@BadalRai](https://www.linkedin.com/in/badal-rai)

## License

This project is licensed under the Apache 2.0 License - see the LICENSE.md file for details    
> **Note**: This content is proprietary and confidential. Unauthorized copying, modification, distribution, or use of this content is strictly prohibited without explicit permission from the owner.


##### Copyright (c) 2024 badalrai21

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
