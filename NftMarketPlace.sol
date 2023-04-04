// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, Ownable {
    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address owner, uint256 tokenId) public onlyOwner {
        _safeMint(owner, tokenId);
    }
}

contract NftMarketPlace
{
    MyToken token = new MyToken();

    mapping(address => mapping(uint  => uint)) private NftTokenPrice;

    constructor(address MyTokenAddress)
    {
        token = MyToken(MyTokenAddress);
    }

    function OwnerOf(uint256 _tokenId) public view returns (address)
    {
        return token.ownerOf(_tokenId);
    }

    function SetNftOnSell(address _owner,uint tokenId ,uint _tokenPrice) public
    {
        require(msg.sender == token.ownerOf(tokenId),"Owner Authorization Needed");
        require( token.ownerOf(tokenId) == _owner,"Enter Valid tokenId");
        NftTokenPrice[_owner][tokenId] = _tokenPrice;

    }

    function TokenSellPrice(address _owner , uint _tokenId) public view returns(uint)
    {
        return  NftTokenPrice[_owner][_tokenId];
    }

    function BuyNft(address _owner , uint _tokenId) public
    {
        token.safeTransferFrom(_owner,msg.sender,_tokenId);
        NftTokenPrice[_owner][_tokenId] = 0;
    }

}