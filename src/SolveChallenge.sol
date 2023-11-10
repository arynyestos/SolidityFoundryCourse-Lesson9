// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {LessonNineInterface} from "src/LessonNineInterface.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";


contract SolveChallenge is IERC721Receiver {
    
    error NFTNotOwnedByContract(uint256 givenAnswer);
    
    address constant LESSON_NINE_CHALLENGE_ADDRESS = 0x33e1fD270599188BB1489a169dF1f0be08b83509;
    address owner;

    constructor() IERC721Receiver() {
        owner = msg.sender;
    }
    
    function solveChallenge() external {            
        LessonNineInterface challengeContract = LessonNineInterface(LESSON_NINE_CHALLENGE_ADDRESS);
        uint256 ourGuess = uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 100000;
        challengeContract.solveChallenge(ourGuess, "@ynyesto");            
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external override returns (bytes4) {
        forwardNFT(msg.sender, tokenId);
        return this.onERC721Received.selector; 
    }

    function forwardNFT(address nftAddress, uint256 tokenId) private {
        IERC721 nft = IERC721(nftAddress);

        if(nft.ownerOf(tokenId) != address(this)) revert NFTNotOwnedByContract(tokenId);
        
        nft.transferFrom(address(this), owner, tokenId);
    }   

}