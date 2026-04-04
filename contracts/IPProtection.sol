// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChainIP {

    enum Role { None, Admin, Verifier, Creator }
    enum Status { Pending, Verified, Rejected }

    struct IP {
        uint id;
        address owner;
        string hash;
        string metadata;
        Status status;
    }

    uint public ipCount;

    mapping(uint => IP) public ips;
    mapping(address => Role) public roles;

    event IPRegistered(uint id, address owner);
    event IPVerified(uint id);
    event OwnershipTransferred(uint id, address newOwner);
    event IPLicensed(uint id, address buyer);

    modifier onlyAdmin() {
        require(roles[msg.sender] == Role.Admin, "Not admin");
        _;
    }

    modifier onlyVerifier() {
        require(roles[msg.sender] == Role.Verifier, "Not verifier");
        _;
    }

    modifier onlyCreator() {
        require(roles[msg.sender] == Role.Creator, "Not creator");
        _;
    }

    constructor() {
        roles[msg.sender] = Role.Admin;
    }

    // 🔥 Assign roles
    function assignRole(address user, Role role) public onlyAdmin {
        roles[user] = role;
    }

    // 🔥 Register IP
    function registerIP(string memory hash, string memory metadata) public onlyCreator {
        ipCount++;

        ips[ipCount] = IP({
            id: ipCount,
            owner: msg.sender,
            hash: hash,
            metadata: metadata,
            status: Status.Pending
        });

        emit IPRegistered(ipCount, msg.sender);
    }

    // 🔥 Verify IP
    function verifyIP(uint ipId) public onlyVerifier {
        require(ipId <= ipCount, "Invalid ID");
        ips[ipId].status = Status.Verified;

        emit IPVerified(ipId);
    }

    // 🔥 Transfer Ownership
    function transferOwnership(uint ipId, address newOwner) public {
        require(ips[ipId].owner == msg.sender, "Not owner");

        ips[ipId].owner = newOwner;

        emit OwnershipTransferred(ipId, newOwner);
    }

    // 🔥 License IP
    function licenseIP(uint ipId, address buyer) public {
        require(ips[ipId].status == Status.Verified, "Not verified");

        emit IPLicensed(ipId, buyer);
    }

    // 🔍 Get role
    function getRole(address user) public view returns (Role) {
        return roles[user];
    }


    // 🔥 ADD THIS AT THE END OF CONTRACT

    function getTotalIPs() public view returns (uint) {
        return ipCount;
    }

    function getOwnerIPs(address user) public view returns (uint[] memory) {
        uint[] memory temp = new uint[](ipCount);
        uint count = 0;

        for (uint i = 1; i <= ipCount; i++) {
            if (ips[i].owner == user) {
                temp[count] = i;
                count++;
            }
        }

        uint[] memory result = new uint[](count);
        for (uint j = 0; j < count; j++) {
            result[j] = temp[j];
        }

        return result;
    }
}