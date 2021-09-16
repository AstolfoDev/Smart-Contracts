pragma solidity ^0.4.17;

/*
    * This contract generates a pseudo-random value using the current block difficulty.
    * :P
*/

contract randomcontract {
    
    // Creates starting 'random' variable with current block diff.
    uint private randomvalue = generateValue();
    mapping(uint => bool) private history;
    
    // Function pushes value to the end of the history storage.
    function pushToHistory(uint value) private {
        history[value] = true;
    }
    
    // Function checks if value exists in the history storage.
    function getHistory(uint value) public view returns (bool) {
        return history[value];
    }
    
    // Function regens the 'random' variable with the latest block diff. until a value that hasn't been used in history is found.
    function generateValue() public returns (uint) {
        randomvalue = uint(keccak256(block.difficulty, now));
        while (history[randomvalue] == true) {
            randomvalue = uint(keccak256(block.difficulty, now));
        }
        pushToHistory(randomvalue);
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
    function getWithinGen(uint max) public returns (uint) {
        generateValue();
        return randomvalue % max;
    }
    
}