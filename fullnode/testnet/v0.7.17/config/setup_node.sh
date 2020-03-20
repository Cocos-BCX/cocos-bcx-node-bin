#!/bin/bash

# genesis.json witness_node config.ini 都在当前路径下
# genesis.json 创世区块文件
# config.ini: witness_node 启动的加载配置

echo "=================== run start ==================="

nohup ./witness_node --genesis-json genesis.json >> witness_node.log 2>&1 &

sleep 5

# 如果当前服务器上运行多个witness_node, 使用pkill 会全部kill掉
# kill -15 pid   ## 不要使用 kill -9 会产生脏数据
# ps -ef | grep witness_node | grep -v grep | cut -c 9-15 | xargs kill -15
pkill witness_node

cp config.ini ./witness_node_data_dir/config.ini

nohup ./witness_node --genesis-json genesis.json >> witness_node.log 2>&1 &

sleep 3

#echo "save chain id to chainID.log"
grep -n "Chain ID is" witness_node.log >> chainID.log

echo "=================== run done ==================="
