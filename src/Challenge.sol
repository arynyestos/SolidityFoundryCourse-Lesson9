// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract LessonNineChallenge {
    error LessonNine__WrongValue(uint256 givenAnswer);

    event ChallengeSolved(uint256 indexed givenAnswer, uint256 indexed correctAnswer);

    constructor() {}

    /*
     * CALL THIS FUNCTION!
     * 
     * @param randomGuess - Your random guess... or not so random
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(uint256 randomGuess) external {
        // Do we have a 1 in 100,000 chance of getting it right?
        // ...or can we cheat?
        uint256 correctAnswer =
            uint256(keccak256(abi.encodePacked(msg.sender, block.prevrandao, block.timestamp))) % 100000;

        if (randomGuess == correctAnswer) {
            emit ChallengeSolved(randomGuess, correctAnswer);
            // emit ChallengeSolved(correctAnswer);
        } else {
            revert LessonNine__WrongValue(randomGuess);
        }
    }

}