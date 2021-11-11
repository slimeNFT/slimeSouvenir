//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract SlimeSouvenir is ERC721Enumerable, Ownable {
    // Token base URI
    string public baseURI;
    // Token max supply
    uint256 public MAX_SUPPLY = 7292;

    constructor() ERC721("Slime Souvenir", "SSR") {
        baseURI = "https://souvenir.slime.pet/";
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        require(to != address(0), "Address invalid");
        require(tokenId > 0 && tokenId <= 7292, "id err");
        require(totalSupply() <= MAX_SUPPLY, "Over maximum supply");
        _safeMint(to, tokenId);
    }

    function walletOfOwner(address _owner) public view returns(uint256[] memory) {
        uint256 tokenCount = balanceOf(_owner);

        uint256[] memory tokensId = new uint256[](tokenCount);
        for(uint256 i; i < tokenCount; i++){
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
}