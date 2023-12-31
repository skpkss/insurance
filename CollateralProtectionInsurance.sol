// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CollateralProtectionInsurance {
    address public owner;
    uint public coveragePercentage;
    bool public isClaimed;
    uint public protectedAmount;

    constructor(uint _coveragePercentage, address _owner) {
        require(_coveragePercentage <= 100, "Invalid coverage percentage");
        coveragePercentage = _coveragePercentage;
        owner = _owner;
        isClaimed = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function claimCollateralProtection(uint collateralValue) external onlyOwner {
        require(!isClaimed, "Protection already claimed");

        if (coveragePercentage == 100) {
            protectedAmount = collateralValue; // Claim 100% of collateral
        } else {
            // Calculate protected amount based on coverage percentage and collateral value
            protectedAmount = (collateralValue * coveragePercentage) / 100;
        }
        isClaimed = true;
    }
}
