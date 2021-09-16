pragma solidity ^0.4.17;

/*
    * This contract generates a pseudo-random value using the current block difficulty.
    * :P
*/

contract randomcontract {
    
    // Creates starting 'random' variable with current block diff.
    uint private randomvalue = uint(keccak256(block.difficulty, now));
    
    // Function regens the 'random' variable with the latest block diff.
    function regenerateValue() public returns (uint) {
        randomvalue = uint(keccak256(block.difficulty, now));
        return randomvalue;
    }
    
    // Function returns the last saved block diff.
    function getValue() public view returns (uint) {
        return randomvalue;
    }
    
    // Function uses the last saved block diff. to return number > max.
    function getWithin(uint max) public view returns (uint) {
        return randomvalue % max;
    }
    
    // Function regens the 'random' variable and uses latest block diff. to return number > max.
    function getWithinRegen(uint max) public returns (uint) {
        regenerateValue();
        return randomvalue % max;
    }
    
}