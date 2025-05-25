// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TreasurySecurity {
    address public owner;
    mapping(address => bool) public signers;
    uint public requiredSignatures;
    uint public balance;

    struct Transaction {
        address recipient;
        uint amount;
        uint approvals;
        mapping(address => bool) approved;
        bool executed;
    }

    Transaction[] public transactions;

    constructor(uint _requiredSignatures) {
        owner = msg.sender;
        requiredSignatures = _requiredSignatures;
    }

    function deposit() external payable {
        balance += msg.value;
    }

    function proposeTransaction(address _recipient, uint _amount) public {
        require(signers[msg.sender], "Not an authorized signer");
        Transaction storage newTx = transactions.push();
        newTx.recipient = _recipient;
        newTx.amount = _amount;
    }

    function approveTransaction(uint txIndex) public {
        require(signers[msg.sender], "Not an authorized signer");
        Transaction storage txn = transactions[txIndex];
        require(!txn.approved[msg.sender], "Already approved");
        txn.approved[msg.sender] = true;
        txn.approvals++;

        if (txn.approvals >= requiredSignatures) {
            executeTransaction(txIndex);
        }
    }

    function executeTransaction(uint txIndex) private {
        Transaction storage txn = transactions[txIndex];
        require(!txn.executed, "Already executed");
        require(balance >= txn.amount, "Insufficient funds");
        
        payable(txn.recipient).transfer(txn.amount);
        txn.executed = true;
    }
}
