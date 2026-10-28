 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.38;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WhisperTreasury {
    IERC20 public immutable tiltToken;
    uint256 public immutable deploymentChainId;
    address public immutable administrator;

    address public constant MAINNET_TILT_ADDRESS = 0x3eB7e262a9246B877aF7aed3f0F6a80Bebb3AcE0;
    uint8 public constant TILT_DECIMALS = 18;
    uint256 public constant TILT_DUST_PER_TILT = 1e18;

    modifier onlyAdministrator() {
        require(msg.sender == administrator, "Unauthorized administrator");
        _;
    }

    address public immutable emergencyGuardian;

    modifier onlyEmergencyGuardian() {
        require(msg.sender == emergencyGuardian, "Unauthorized guardian");
        _;
    }

    bool public paused;

    event PauseChanged(bool paused);

    function unpause() external onlyAdministrator {
        require(paused, "Not paused");
        paused = false;
        emit PauseChanged(false);
    }

    function pause() external onlyEmergencyGuardian {
        require(!paused, "Already paused");
        paused = true;
        emit PauseChanged(true);
    }

    constructor(address tiltTokenAddress, address administratorAddress, address guardianAddress, uint256 expectedChainId) {
        require(tiltTokenAddress != address(0), "Invalid TILT token");
        require(tiltTokenAddress.code.length > 0, "TILT token must be a deployed contract");
        require(administratorAddress != address(0), "Invalid administrator");

        require(expectedChainId == 80002 || expectedChainId == 137, "Unsupported Polygon network");
        require(block.chainid == expectedChainId, "Incorrect blockchain");
        if (expectedChainId == 137) {
            require(tiltTokenAddress == MAINNET_TILT_ADDRESS, "Incorrect mainnet TILT token");
        }
        deploymentChainId = expectedChainId;
        tiltToken = IERC20(tiltTokenAddress);
        require(guardianAddress != address(0) && guardianAddress != administratorAddress, "Invalid guardian");
        administrator = administratorAddress;
        emergencyGuardian = guardianAddress;
    }
}
