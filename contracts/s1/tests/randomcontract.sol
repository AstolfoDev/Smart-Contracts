pragma solidity ^0.4.17;

/*
    * This contract generates a pseudo-random value using the current block difficulty.
    * :P
*/

contract randomcontract {
    
    // Creates starting 'random' variable with current block diff.
    uint256 private randomvalue = generateValue();
    mapping(uint256 => bool) private history;
    
    // Function pushes value to the end of the history storage.
    function pushToHistory(uint256 value) private {
        history[value] = true;
    }
    
    // Function checks if value exists in the history storage.
    function getHistory(uint256 value) public view returns (bool) {
        return history[value];
    }
    
    // Function regens the 'random' variable with the latest block diff. until a value that hasn't been used in history is found.
    function generateValue() public returns (uint256) {
        
        randomvalue = uint256 (
            keccak256 (
                abi.encodePacked(block.difficulty, now)
            )
        );
        
        while (history[randomvalue] == true) {
            randomvalue = uint256 (
                keccak256 (
                    abi.encodePacked(block.difficulty, now)
                )
            );
        }
        
        pushToHistory(randomvalue);
        
        return randomvalue;
    }
    
    // Function returns the last saved block diff.
    function getValue() public view returns (uint256) {
        return randomvalue;
    }
    
    // Function uses the last saved block diff. to return number < max.
    function getWithin(uint256 max) public view returns (uint256) {
        return randomvalue % max;
    }
    
    // Function regens the 'random' variable and uses latest block diff. to return number < max.
    function getWithinGen(uint256 max) public returns (uint256) {
        generateValue();
        return randomvalue % max;
    }
    
}