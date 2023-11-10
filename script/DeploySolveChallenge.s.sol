// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {SolveChallenge} from "../src/SolveChallenge.sol";

contract DeploySolveChallenge is Script {
    function run() external returns (SolveChallenge) {

        // Deploy Challenge contract
        vm.startBroadcast();
        SolveChallenge solveChallenge = new SolveChallenge();
        vm.stopBroadcast();

        return (solveChallenge);
    }
}