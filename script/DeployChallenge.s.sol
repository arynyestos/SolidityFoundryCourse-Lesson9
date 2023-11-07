// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {LessonNineChallenge} from "../src/Challenge.sol";

contract DeployChallenge is Script {
    function run() external returns (LessonNineChallenge) {

        // Deploy Challenge contract
        vm.startBroadcast();
        LessonNineChallenge challenge = new LessonNineChallenge();
        vm.stopBroadcast();

        return (challenge);
    }
}