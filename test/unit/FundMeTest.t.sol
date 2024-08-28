//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test, DeployFundMe {
    //uint256 number = 1;
    FundMe fundMe;

    function setUp() external {
        //number = 2;
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        (fundMe, ) = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public view {
        // console.log(number);
        // console.log("Hello!");
        // assertEq(number, 2);
        console.log(fundMe.MINIMUM_USD());
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), msg.sender);
    }

    // what can we do to work with addresses outside our system?
    // 1. Unit
    //      - Testing a specific part of our code.
    // 2. Integration
    //      - Testing how our code works with other parts of our code
    // 3. Forked
    //      - Testing our code on a simulated real environment
    // 4. Staging
    //      - Testing our code in a real envitomment that is not production

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
