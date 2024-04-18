pragma solidity 0.4.12;



/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Users {

    struct Actor {
        uint id;
        string name; 
        Role roles;
    }

    struct Products {
        address id;
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

    modifier onlyManufacturer() {
        require(msg.sender.roles == Manufacturer, "Not authorized operation");
        _;
    }

     // Array to store users
    Actor[] public users;

    // Function to add a user
    function addUser(uint id, string memory name, Role role) public {
        Actor newUser = Actor(id, name, role);
        require(msg.sender.roles == Manufacturer && newUser.roles != Supplier, "Cannot add vendor or customer");
        require(msg.sender.roles == Supplier && newUser.roles != Vendor, "Cannot add vendor or customer");
        require(msg.sender.roles == Vendor && newUser.roles != Customer, "Cannot add vendor or customer");
        require(msg.sender.roles != Customer, "Cannot add a user");
        users.push(newUser);
    }

    // Function to get the total number of users
    function getTotalUsers() public returns (uint) {
        return users.length;
    }
}