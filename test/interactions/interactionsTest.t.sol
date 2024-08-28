// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
import {FundMe} from "../../src/FundMe.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract InteractionsTest is StdCheats, Test {
    FundMe public fundMe;
    HelperConfig public helperConfig;

    uint256 public constant SEND_VALUE = 0.1 ether; // just a value to make sure we are sending enough!
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    uint256 public constant GAS_PRICE = 1;

    address public constant USER = address(1);

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        (fundMe, helperConfig) = deployer.deployFundMe();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

    function testUserCanFundAndOwnerWithdraw() public {
        uint256 preUserBalance = address(USER).balance;
        uint256 preOwnerBalance = address(fundMe.getOwner()).balance;

        // Using vm.prank to simulate funding from the USER address
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        uint256 afterUserBalance = address(USER).balance;
        uint256 afterOwnerBalance = address(fundMe.getOwner()).balance;

        // uint256 gasCost = tx.gasprice *
        //     (preUserBalance - afterUserBalance - SEND_VALUE);

        // Log balances for debugging
        console.log("Pre-User Balance: ", preUserBalance);
        console.log("After-User Balance: ", afterUserBalance);
        console.log("Pre-Owner Balance: ", preOwnerBalance);
        console.log("After-Owner Balance: ", afterOwnerBalance);

        // Adjust for gas cost in the assertion
        assert(address(fundMe).balance == 0);
        assertEq(afterUserBalance + SEND_VALUE, preUserBalance);
        assertEq(preOwnerBalance + SEND_VALUE, afterOwnerBalance);
    }
}

// 10000000000000000000
// 9900000000000000000

// 79228162653955109644497236764
// 79228162654063109644497236764

// function testUserCanFundAndOwnerWithdraw() public {
//     uint256 preUserBalance = address(USER).balance;
//     uint256 preOwnerBalance = address(fundMe.getOwner()).balance;

//     // Using vm.prank to simulate funding from the USER address
//     vm.prank(USER);
//     fundMe.fund{value: SEND_VALUE}();

//     WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
//     withdrawFundMe.withdrawFundMe(address(fundMe));

//     uint256 afterUserBalance = address(USER).balance;
//     uint256 afterOwnerBalance = address(fundMe.getOwner()).balance;

//     uint256 gasCost = tx.gasprice *
//         (preUserBalance - afterUserBalance - SEND_VALUE);

//     // Adjust for gas cost in the assertion
//     assert(address(fundMe).balance == 0);
//     assertEq(afterUserBalance + SEND_VALUE + gasCost, preUserBalance);
//     assertEq(preOwnerBalance + SEND_VALUE, afterOwnerBalance);
// }
