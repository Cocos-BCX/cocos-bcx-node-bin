[中文](https://github.com/Cocos-BCX/cocos-bcx-node-bin/blob/master/cli/README_cn.md "中文")

# 1. RPC Command Line Wallet Terminal
    Note: The prerequisite is that the blockchain has been correctly built without any error after testing, and the RPC address of the node is obtained.

## 1.1.	Open the command line wallet

* ./cli_wallet --chain-id Newly generated chain id -s ws://127.0.0.1:8049 -r 127.0.0.1:8099
    
  * The chain ID can be found by viewing the running log of the node. The address after the -s parameter is the RPC address of the node, and the address after the -r parameter is the RPC listening address of the command line wallet.

## 1.2.	Operating command line wallet

* set_password xxxx Set the password for wallet
    
* unlock xxxx Unlock the wallet
