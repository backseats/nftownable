// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

abstract contract NFTOwnable is ERC721 {
    uint256 public constant OWNER_TOKEN_ID = 0;

    error OwnableUnauthorizedAccount(address account);
    error OwnableInvalidOwner(address owner);

    constructor(address initialOwner)
        ERC721("Contract Ownership", "OWNER")
    {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }

        _mint(initialOwner, OWNER_TOKEN_ID);
    }

    function owner() public view virtual returns (address) {
        return ownerOf(OWNER_TOKEN_ID);
    }

    modifier onlyOwner() {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }

        _;
    }
}