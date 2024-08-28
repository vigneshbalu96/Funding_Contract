//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    // function run() external returns (FundMe) {
    //     HelperConfig helperConfig = new HelperConfig();

    //     //we have to wrap the address in a paranthisis ( , , , , ) coz this is a NetworkConfig struct but we have only one address paremeter so okay not to have ()
    //     address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

    //     vm.startBroadcast();
    //     FundMe fundMe = new FundMe(ethUsdPriceFeed);
    //     vm.stopBroadcast();
    //     return fundMe;
    // }

    function deployFundMe() public returns (FundMe, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        address priceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();

        return (fundMe, helperConfig);
    }

    function run() external returns (FundMe, HelperConfig) {
        return deployFundMe();
    }
}
