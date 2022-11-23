// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract VoterList {
    address public owner;
    mapping(address => bool) whiteList;
    mapping(address => uint256) lastEdit;

    modifier isOwner() {
        require(msg.sender != owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function add(address entry) external isOwner returns (bool) {
        whiteList[entry] = true;
        return true;
    }

    function remove(address entry) external isOwner returns (bool) {
        whiteList[entry] = false;
        return true;
    }

    function update(address old, address nu) external isOwner returns (bool) {
        whiteList[old] = false;
        whiteList[nu] = true;
        return true;
    }

    // Let a non-owner update the pool (with the owner's permission)
    function update_for(
        address old,
        address nu,
        uint256 editTime,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (bool) {
        // Validate request
        bytes32 h = keccak256(
            abi.encodePacked(address(this), old, nu, editTime)
        );
        if (owner != ecrecover(h, v, r, s)) return false;
        if (editTime <= lastEdit[nu]) return false;

        // Execute update
        whiteList[old] = false;
        whiteList[nu] = true;
        lastEdit[nu] = editTime;

        return true;
    }

    function is_voter(address entry) public view returns (bool) {
        return whiteList[entry];
    }

    // Compute has directly from contract so there is no confusion
    function get_hash(
        address old,
        address nu,
        uint256 editTime
    ) public view returns (bytes32) {
        return keccak256(abi.encodePacked(address(this), old, nu, editTime));
    }
}
