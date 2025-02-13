// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; // This is the solidity version

contract SimpleStorge {
    // Basic Types: Boolean, uint, int, address, bytes
    bool hasFavoriteNumber = true;
    uint256 favoriteNumber;
    string favoriteNumberInText = "Eighty-eight";
    int256 favoriteInt = -88; //Ints can be negative numbers
    address myAddress = 0x2d89034424Db22C9c555f14692a181B22B17E42C;
    bytes favoriteBytes ="Dog";

    struct Person{
        uint256 myFavoriteNumber;
        string name;
    }
    // dynamic array
    Person[] public listOfPeople; // A public array that anyone can add a person type to
    // Chelsea -> 88
    mapping (string => uint256) public nameToFavoriteNumber;


    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push( Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber; //This line maps the persons name to their fav num when the function is called    } // This function accepts a new persons name and favnumber and adds it to the listofpeople array
    }
}