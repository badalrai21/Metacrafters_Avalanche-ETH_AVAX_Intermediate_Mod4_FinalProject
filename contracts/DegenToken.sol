// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract FantasyToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("FantasyToken", "FT") Ownable(msg.sender) {}

    // Enum for different fantasy items
    enum FantasyItem { Heal, Potion, Sword, Shield, Magic }

    struct Player {
        address playerAddress;
        uint256 amount;
    }

    Player[] public playerQueue;

    struct PlayerInventory {
        uint256 heal;
        uint256 potion;
        uint256 sword;
        uint256 shield;
        uint256 magic;
    }

    mapping(address => PlayerInventory) public playerInventories;

    function buyTokens(address _playerAddress, uint256 _amount) public {
        playerQueue.push(Player({ playerAddress: _playerAddress, amount: _amount }));
    }

    function distributeTokens() public onlyOwner {
        while (playerQueue.length > 0) {
            uint256 lastIndex = playerQueue.length - 1;
            if (playerQueue[lastIndex].playerAddress != address(0)) {
                _mint(playerQueue[lastIndex].playerAddress, playerQueue[lastIndex].amount);
                playerQueue.pop();
            }
        }
    }

    function transferTokens(address _to, uint256 _amount) public {
        require(_amount <= balanceOf(msg.sender), "Insufficient tokens");
        _transfer(msg.sender, _to, _amount);
    }

    function redeemItem(FantasyItem _item) public {
        uint256 requiredTokens;
        if (_item == FantasyItem.Heal) {
            requiredTokens = 10;
        } else if (_item == FantasyItem.Potion) {
            requiredTokens = 20;
        } else if (_item == FantasyItem.Sword) {
            requiredTokens = 30;
        } else if (_item == FantasyItem.Shield) {
            requiredTokens = 40;
        } else if (_item == FantasyItem.Magic) {
            requiredTokens = 50;
        } else {
            revert("Invalid item selected");
        }

        require(balanceOf(msg.sender) >= requiredTokens, "Insufficient tokens");

        if (_item == FantasyItem.Heal) {
            playerInventories[msg.sender].heal++;
        } else if (_item == FantasyItem.Potion) {
            playerInventories[msg.sender].potion++;
        } else if (_item == FantasyItem.Sword) {
            playerInventories[msg.sender].sword++;
        } else if (_item == FantasyItem.Shield) {
            playerInventories[msg.sender].shield++;
        } else if (_item == FantasyItem.Magic) {
            playerInventories[msg.sender].magic++;
        }

        _burn(msg.sender, requiredTokens);
    }

    function burnTokens(uint256 _amount) public {
        _burn(msg.sender, _amount);
    }

    function checkTokenBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
