// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Users.sol";
import "./Owner.sol";

contract Product {

    event ProductTransferred(uint productId, address from, address to);
    Product[] public products;


   function addProduct(address id, string memory nameProduct, uint nbBatch, uint nbProductsPerBatch) public onlyManufacturer {
        require(!isProductIdExists(_productId), "Product ID already exists");
        // Create a new product and add it to the array
        products.push(Product(id, nameProduct, nbBatch, nbProductsPerBatch, msg.sender));
    }

    // Function to check if a product ID already exists
    function isProductIdExists(uint _productId) internal view returns (bool) {
        for (uint i = 0; i < products.length; i++) {
            if (products[i].productId == _productId) {
                return true;
            }
        }
        return false;
    }

    function transferProductOwnership(uint _productId, address _newOwner) external onlyWhitelisted {
            require(products[_productId].id != 0, "Product does not exist");
            require(products[_productId].lastOwner == msg.sender, "You are not the owner of this product");
            products[_productId].lastOwner = _newOwner;
            emit ProductTransferred(_productId, msg.sender, _newOwner);
        }
   


}    
   

