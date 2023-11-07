// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {LessonNineChallenge} from "../../src/Challenge.sol";
import {DeployChallenge} from "../../script/DeployChallenge.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";

contract ChallengeTest is Test {

    LessonNineChallenge challenge;
    // address public PLAYER = makeAddr("player");
    address public PLAYER = 0x31e0FacEa072EE621f22971DF5bAE3a1317E41A4;

    function setUp() external {
        DeployChallenge deployer = new DeployChallenge();
        (challenge) = deployer.run();
    }

    
    function testWrongSolveChallenge() public {
        // Arrange
        vm.prank(PLAYER);
        uint256 ourGuess = 0;

        // Act and assert
        // vm.recordLogs();
        // challenge.solveChallenge(ourGuess);
        // Vm.Log[] memory logs = vm.getRecordedLogs();
        // bytes32 givenAnswer = logs[0].topics[1];
        vm.expectRevert(
            abi.encodeWithSelector(
                LessonNineChallenge.LessonNine__WrongValue.selector,
                ourGuess
            )
        );
        challenge.solveChallenge(ourGuess);
    }
    
    function testSolveChallenge() public {
        // Arrange
        vm.prank(PLAYER);
        uint256 ourGuess = uint256(keccak256(abi.encodePacked(PLAYER, block.prevrandao, block.timestamp))) % 100000;

        // Act 
        vm.recordLogs();
        challenge.solveChallenge(ourGuess);
        Vm.Log[] memory entries = vm.getRecordedLogs();

        bytes32 correctAnswer = entries[0].topics[2];
        
        // Assert
        assert(ourGuess == uint256(correctAnswer));        
        assertEq(entries.length, 1);
        assertEq(entries[0].topics[0], keccak256("ChallengeSolved(uint256,uint256)"));
        assertEq(entries[0].topics[1], bytes32(ourGuess));
        
        console.log("The correct answer is: ", uint256(correctAnswer));
    }
}