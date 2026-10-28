// SPDX-License-Identifier: MIT
pragma solidity ^0.8.38;

import {Test} from "forge-std/Test.sol";
import {WhisperTreasury} from "../contracts/WhisperTreasury.sol";
import {MockTILT} from "./MockTILT.sol";

contract WhisperTreasurySecurityTest is Test {
    WhisperTreasury treasury;
    MockTILT mockTilt;
    address administrator = address(0xA11CE);
    address guardian = address(0xB0B);
    address attacker = address(0xBAD);

    function setUp() public {
        vm.chainId(80002);
        mockTilt = new MockTILT();
        treasury = new WhisperTreasury(address(mockTilt), administrator, guardian, 80002);
    }

    function testGuardianCanPause() public {
        vm.prank(guardian);
        treasury.pause();
        assertTrue(treasury.paused());
    }

    function testOnlyAdministratorCanUnpause() public {
        vm.prank(guardian);
        treasury.pause();
        vm.prank(guardian);
        vm.expectRevert();
        treasury.unpause();
        assertTrue(treasury.paused());
        vm.prank(attacker);
        vm.expectRevert();
        treasury.unpause();
        assertTrue(treasury.paused());
        vm.prank(administrator);
        treasury.unpause();
        assertFalse(treasury.paused());
    }

    function testRepeatedPauseRejected() public {
        vm.prank(guardian);
        treasury.pause();
        vm.prank(guardian);
        vm.expectRevert();
        treasury.pause();
        assertTrue(treasury.paused());
    }

    function testRepeatedUnpauseRejected() public {
        vm.prank(guardian);
        treasury.pause();
        vm.prank(administrator);
        treasury.unpause();
        vm.prank(administrator);
        vm.expectRevert();
        treasury.unpause();
        assertFalse(treasury.paused());
    }

    function testRejectsZeroAdministrator() public {
        vm.expectRevert(bytes("Invalid administrator"));
        new WhisperTreasury(address(mockTilt), address(0), guardian, 80002);
    }

    function testRejectsInvalidGuardians() public {
        vm.expectRevert(bytes("Invalid guardian"));
        new WhisperTreasury(address(mockTilt), administrator, address(0), 80002);
        vm.expectRevert(bytes("Invalid guardian"));
        new WhisperTreasury(address(mockTilt), administrator, administrator, 80002);
    }

    function testRejectsZeroTiltToken() public {
        vm.expectRevert(bytes("Invalid TILT token"));
        new WhisperTreasury(address(0), administrator, guardian, 80002);
    }

    function testRejectsWrongChainId() public {
        vm.chainId(80002);
        vm.expectRevert(bytes("Incorrect blockchain"));
        new WhisperTreasury(address(mockTilt), administrator, guardian, 137);
    }

    function testRejectsUnsupportedChain() public {
        vm.chainId(1);
        vm.expectRevert(bytes("Unsupported Polygon network"));
        new WhisperTreasury(address(mockTilt), administrator, guardian, 1);
    }

    function testRejectsFakeMainnetTilt() public {
        vm.chainId(137);
        vm.expectRevert(bytes("Incorrect mainnet TILT token"));
        new WhisperTreasury(address(mockTilt), administrator, guardian, 137);
    }

    function testAcceptsCorrectMainnetTilt() public {
        vm.chainId(137);
        address expectedToken = 0x3eB7e262a9246B877aF7aed3f0F6a80Bebb3AcE0;
        vm.etch(expectedToken, address(mockTilt).code);
        WhisperTreasury mainnetTreasury = new WhisperTreasury(expectedToken, administrator, guardian, 137);
        assertEq(address(mainnetTreasury.tiltToken()), expectedToken);
        assertEq(mainnetTreasury.deploymentChainId(), 137);
    }

    function testAttackerCannotPause() public {
        vm.prank(attacker);
        vm.expectRevert();
        treasury.pause();
        assertFalse(treasury.paused());
    }
    function testRejectsTokenAddressWithoutContractCode() public {
        address fakeToken = address(0x1234);
        assertEq(fakeToken.code.length, 0);
        vm.expectRevert(bytes("TILT token must be a deployed contract"));
        new WhisperTreasury(fakeToken, administrator, guardian, 80002);
    }

}
