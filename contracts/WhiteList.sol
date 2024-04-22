pragma solidity ^0.8.0;

import "./Owner.sol";
import "./Products.sol";


// SPDX-License-Identifier: GPL-3.0


contract Whitelist is Ownable{


    // Whitelisted address
    mapping(address => bool) public whitelist;
    event AddedBeneficiary(address indexed _beneficiary);


    function isWhitelisted(address _beneficiary) internal view returns (bool) {
      return (whitelist[_beneficiary]);
    }

    /**
     * @dev Adds list of addresses to whitelist. Not overloaded due to limitations with truffle testing.
     * @param _beneficiaries Addresses to be added to the whitelist
     */
    function addToWhitelist(address _beneficiaries) public  {
    
        whitelist[_beneficiaries] = true;
      }
    

    /**
     * @dev Removes single address from whitelist.
     * @param _beneficiary Address to be removed to the whitelist
     */
    function removeFromWhitelist(address _beneficiary) public onlyOwner {
      whitelist[_beneficiary] = false;
    }

    modifier onlyWhitelisted()
    {
      require(whitelist[msg.sender] == true, "Is not whitelisted" );
      _;
    }
  }
