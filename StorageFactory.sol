// SPDX-License-Identifier: MIT
// Contracts can deploy other contracts. 
pragma solidity ^0.8.19;

import "./SimpleStorage.sol";

contract StorageFactory {
     SimpleStorage[] public listOfSimpleStorageContracts;

     function createSimpleStorageContract() public {
          SimpleStorage SimpleStorgeContractVariable = new SimpleStorage();
          // SimpleStorage simpleStorage = new SimpleStorage();
          listOfSimpleStorageContracts.push(SimpleStorgeContractVariable);
     }

     function sfStore(
          uint256 _simpleStorageIndex,
          uint256 _simpleStorageNumber
     ) public {
          // Address
     }         
     
}
