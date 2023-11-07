// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {LessonNineChallenge} from "../src/Challenge.sol";
import {LessonNineInterface} from "src/LessonNineInterface.sol";
import {console} from "forge-std/console.sol";

contract SolveChallenge is Script {

    address CONTRACT_ADDRESS = 0x33e1fD270599188BB1489a169dF1f0be08b83509;

    function run() external {

        // Deploy Challenge contract
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        LessonNineInterface challengeContract = LessonNineInterface(CONTRACT_ADDRESS);
        uint256 ourGuess = uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 100000;
        challengeContract.solveChallenge(ourGuess, "@ynyesto");
        vm.stopBroadcast();
    }
}