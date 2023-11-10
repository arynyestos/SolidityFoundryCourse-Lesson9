// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {LessonNineChallenge} from "../src/Challenge.sol";
import {LessonNineInterface} from "src/LessonNineInterface.sol";
import {console} from "forge-std/console.sol";

contract SolveChallenge is Script {

    // address CONTRACT_ADDRESS = 0x33e1fD270599188BB1489a169dF1f0be08b83509;
    address CONTRACT_ADDRESS = 0x90193C961A926261B756D1E5bb255e67ff9498A1;

    function run() external {

        // Deploy Challenge contract
        // vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vm.startBroadcast();
        LessonNineInterface challengeContract = LessonNineInterface(CONTRACT_ADDRESS);
        console.log(msg.sender);
        console.log(address(this));
        uint256 ourGuess = uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 100000;
        challengeContract.solveChallenge(ourGuess, "@ynyesto");
        console.log("Our guess: ", ourGuess);
        // challengeContract.solveChallenge(ourGuess);
        vm.stopBroadcast();
    }
}