[English](https://github.com/Cocos-BCX/cocos-bcx-node-bin/blob/master/cli/testnet/README.md "English")

# 1. RPC命令行钱包终端使用
    注：前置条件是链已正确搭建，测试无误，且获取到节点的RPC地址。

## 1.1.	开启命令行钱包

* ./cli_wallet --chain-id 新生成的链id -s ws://127.0.0.1:8049  -r  127.0.0.1:8099
    
  * 其中链ID通过查看节点运行日志获取，-s参数后的地址为节点的RPC地址，-r参数后的地址为命令行钱包的RPC监听地址。

## 1.2.	操作命令行钱包

* set_password xxxx 设置钱包密码
    
* unlock xxxx 解锁钱包

