pragma solidity ^0.8.0;

contract RentAgreement {
    struct Agreement {
        address tenant;
        address landlord;
        uint256 rentAmount;
        uint256 duration;
        uint256 startTime;
        bool isActive;
    }

    Agreement public rentAgreement;


    modifier onlyTenant() {
        require(msg.sender == rentAgreement.tenant, "Only tenant can call this function.");
        _;
    }

    modifier onlyLandlord() {
        require(msg.sender == rentAgreement.landlord, "Only landlord can call this function.");
        _;
    }

    modifier isActiveAgreement() {
        require(rentAgreement.isActive, "Rent agreement is not active.");
        _;
    }

    constructor(
        address _tenant,
        address _landlord,
        uint256 _rentAmount,
        uint256 _duration
    ) {
        rentAgreement = Agreement({
            tenant: _tenant,
            landlord: _landlord,
            rentAmount: _rentAmount,
            duration: _duration,
            startTime: block.timestamp,
            isActive: true
        });
    }

    function payRent() external payable onlyTenant isActiveAgreement {
        require(msg.value == rentAgreement.rentAmount, "Incorrect rent amount.");
    }

    function endAgreement() external onlyLandlord isActiveAgreement {
        rentAgreement.isActive = false;
    }
}
