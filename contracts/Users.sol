pragma solidity ^0.8.0;




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

    modifier onlyManufacturer(id) {
        for()
        require(Actor[msg.sender].roles == Role.Manufacturer, "Not authorized operation");
        _;
    }

    
    

     // Array to store users
    Actor[] public users;

    // Function to add a user
    function addUser(uint id, string memory name, Role role) public {
        Actor memory newUser = Actor(id, name, role);
        require(msg.sender.roles == Role.Manufacturer && newUser.roles != Role.Supplier, "Cannot add vendor or customer");
        require(msg.sender.roles == Role.Supplier && newUser.roles != Role.Vendor, "Cannot add vendor or customer");
        require(msg.sender.roles == Role.Vendor && newUser.roles != Role.Customer, "Cannot add vendor or customer");
        require(msg.sender.roles != Role.Customer, "Cannot add a user");
        users.push(newUser);
    }

    // Function to get the total number of users
    function getTotalUsers() public returns (uint) {
        return users.length;
    }
}