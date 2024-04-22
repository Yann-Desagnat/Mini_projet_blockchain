// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Owner.sol";
import "./WhiteList.sol";
import "./Products.sol";



contract Users is Ownable, Whitelist {

    struct Actor {
        string name; 
        Role roles;
    }

    struct Products {
        uint id;
        string nameProduct;   
        uint nbBatch;
        uint nbProductsPerBatch;
        address lastOwner;
        uint buyingDate;
    }

    enum Role{
        Manufacturer, // 0
        Supplier, // 1
        Vendor, // 2
        Customer // 3
    }

    mapping(address => Actor) public actors;

    event actorCast(address id, string name, Role role);


     // Array to store users
    address[] public users;

    // Function to add a user
    function addUser(address id, string memory name, Role role) public {
        Actor memory newUser = Actor(name, role);
        Actor memory currentActor = actors[msg.sender];
        emit actorCast(msg.sender, actors[msg.sender].name, actors[msg.sender].roles);
        emit actorCast(msg.sender, actors[msg.sender].name, actors[msg.sender].roles);

        Role currentRole = currentActor.roles;
        if(msg.sender != owner){
        if(currentRole == Role.Manufacturer && role != Role.Supplier){revert("Cannot add manufacturer or customer or supplier");}
        if(currentRole == Role.Supplier && newUser.roles != Role.Vendor){revert( "Cannot add manufacturer or supplier or customer");}
        if(currentRole == Role.Vendor && newUser.roles != Role.Customer){revert( "Cannot add manufacturer or supplier or vendor");}
        if(currentRole == Role.Customer) {revert("Cannot add an actor");}
        }
        actors[id] = Actor(name, role);
        users.push(id);
        addToWhitelist(id);
    }

    // Function to get the total number of users
    function getUsersCount() public view returns (uint) {
        return users.length;
    }
}