-include .env

build :; forge build

deploy-sepolia :
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -VVVV

deploy-mainnet :
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(MAINNET_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -VVVV