// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Users.sol";
import "./WhiteList.sol";
import "./Owner.sol";


contract Product is Ownable, Users {

    Products[] public products;


   function addProduct(string memory nameProduct, uint nbBatch, uint nbProductsPerBatch) public {
    Actor storage currentActor = actors[msg.sender];
        Role currentRole = currentActor.roles;
        require(currentRole == Role.Manufacturer, "Not authorized operation");
        require(!isProductIdExists(products.length), "Product ID already exists");
        // Create a new product and add it to the array
        products.push(Products(products.length+1, nameProduct, nbBatch, nbProductsPerBatch, msg.sender, block.timestamp));
    }

    // Function to check if a product ID already exists
    function isProductIdExists(uint _productId) internal view returns (bool) {
        for (uint i = 0; i < products.length; i++) {
            if (products[i].id == _productId) {
                return true;
            }
        }
        return false;
    }

    function transferProductOwnership(uint _productId, address _newOwner) public onlyWhitelisted {
        Actor memory currentActor = actors[msg.sender];
        Actor memory newActor = actors[_newOwner];
        Role currentRole = currentActor.roles;
        Role role = newActor.roles;
        if(msg.sender != owner){
        if(currentRole == Role.Manufacturer && role != Role.Supplier){revert("Cannot sell to manufacturer or customer or vendor");}
        if(currentRole == Role.Supplier && role != Role.Vendor){revert( "Cannot add manufacturer or supplier or customer");}
        if(currentRole == Role.Vendor && role != Role.Customer){revert( "Cannot add manufacturer or supplier or vendor");}
        if(currentRole == Role.Customer) {revert("Cannot add an actor");}
        }
        require(products[_productId-1].id != 0, "Product does not exist");
        require(products[_productId-1].lastOwner == msg.sender, "You are not the owner of this product");
        products[_productId-1].lastOwner = _newOwner;

        }

    function seeAllProdducts() public view returns( Products[] memory productList) {
        productList = products;
        return productList;
    }
   


}    
   

