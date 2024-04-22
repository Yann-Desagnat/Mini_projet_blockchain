const contractAddress = 'ONTRACT_ADDRESS_HERE';
const abi = [/* ABI from your compiled contract */];

async function loadWeb3() {
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
    } else {
        document.getElementById('status').innerText = 'MetaMask not found. You need to install MetaMask to interact with this page.';
    }
}

async function loadContract() {
    return await new web3.eth.Contract(abi, contractAddress);
}

async function addUser() {
    const address = document.getElementById('userAddress').value;
    const name = document.getElementById('userName').value;
    const role = document.getElementById('userRole').value;
    const contract = await loadContract();
    try {
        await contract.methods.addUser(address, name, role).send({from: ethereum.selectedAddress});
        document.getElementById('status').innerText = 'User added successfully!';
    } catch (error) {
        document.getElementById('status').innerText = 'Error: ' + error.message;
    }
}

async function getUsersCount() {
    const contract = await loadContract();
    const count = await contract.methods.getUsersCount().call();
    document.getElementById('usersCount').innerText = 'Total Users: ' + count;
}

// Load web3 and contract when the window loads
window.addEventListener('load', function() {
    loadWeb3();
});
