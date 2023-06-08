// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/draft-ERC721Votes.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract ECS_Overview is ERC721, ERC721URIStorage, Ownable, EIP712, ERC721Votes {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address payable public originalOwner; 
    address payable public developerAddress; 
    bool public isFirstSale;

    constructor() ERC721("ECS_Overview", "ECSO") EIP712("ECS_Overview", "1") {
        originalOwner = payable(0x12d917e732F81bD8C6b98e6da3D6F7b001bA2592);
        developerAddress = payable(0x5747F9cA5A5744417665565ACF39C4Ea3535589b);
        isFirstSale = true;
    }

    function safeMint(address payable to, uint256 tokenId, string memory tokenUri) public payable {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenUri);

        originalOwner = to;

        originalOwner.transfer((msg.value * 18) / 100);
        developerAddress.transfer((msg.value * 7) / 100);
        
        isFirstSale = false;
    }

    function distributeSecondarySaleIncome(uint256 tokenId) public payable {
        require(ownerOf(tokenId) == address(this), "The NFT does not belong to this contract");

        address payable originalOwnerAddress = this.originalOwner();

        if (isFirstSale == false) {
        originalOwnerAddress.transfer((msg.value * 93) / 100);
        developerAddress.transfer((msg.value * 7) / 100);
        
        } else {
        originalOwnerAddress.transfer((msg.value * 18) / 100);
        developerAddress.transfer(((msg.value * 18) / 100) * 7 / 100);
        }
    }

    
    // The following functions are overrides required by Solidity.

    function _afterTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal override(ERC721, ERC721Votes) {
        super._afterTokenTransfer(from, to, tokenId, batchSize);
        }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
        }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage)
        returns (string memory) {
        return super.tokenURI(tokenId);
        }
}
