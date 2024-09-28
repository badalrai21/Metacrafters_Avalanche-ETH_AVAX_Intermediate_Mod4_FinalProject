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
