// SPDX-License-Identifier: MIT
pragma solidity ^0.8.38;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockTILT is ERC20 {
    constructor() ERC20("Whisper Test TILT", "tTILT") {}
}
