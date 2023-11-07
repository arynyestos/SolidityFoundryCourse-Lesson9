// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface LessonNineInterface {
    function solveChallenge(uint256 randomGuess, string calldata yourTwitterHandle) external;
    function description() external pure returns (string memory);
    function attribute() external pure returns (string memory);
    function specialImage() external pure returns (string memory);
}
