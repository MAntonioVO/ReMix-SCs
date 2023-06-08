// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts@4.8.0/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.8.0/access/Ownable.sol";

/// @custom:security-contact mavo-8@protonmail.com
contract ECS_Overview is ERC1155, Ownable {
    uint256 public constant PDF_ECS_OVERVIEW = 0;
   
    constructor() ERC1155("https://gateway.pinata.cloud/ipfs/QmbXXj6Yxdp8VJ64sfN2z4DgYS34eGgbss67CqyiVbcDwz") {
        _mint(msg.sender, PDF_ECS_OVERVIEW, 1, "");
    }

}
