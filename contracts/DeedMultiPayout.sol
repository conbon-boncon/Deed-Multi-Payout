//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract DeedMultiPayout {
    address public owner;
    address payable public beneficiary;

    uint256 public earliestTime;
    uint256 public amount;

    uint constant public TOTALPAYOUTS = 5;
    uint constant public PAYOUTINTERVAL = 15;
    uint public paidPayout;

    constructor (address _owner, address payable _beneficiary, uint256 time) payable {
        owner = _owner;
        beneficiary = _beneficiary;
        earliestTime = block.timestamp + time;
        amount = msg.value / TOTALPAYOUTS;
    }

    function withdrawMoney() public{
        require(msg.sender == beneficiary, "Only beneficiary can withdraw money");
        require(block.timestamp >= earliestTime, "Payout is early");
        require(paidPayout <= TOTALPAYOUTS, "Reached total payouts");

        uint eligiblePayouts = (block.timestamp - earliestTime) / PAYOUTINTERVAL;
        uint duePayouts = eligiblePayouts - paidPayout;

        duePayouts = duePayouts + paidPayout > TOTALPAYOUTS ? TOTALPAYOUTS - paidPayout : duePayouts;
        paidPayout += duePayouts;
        beneficiary.transfer(duePayouts * amount);
    }
}