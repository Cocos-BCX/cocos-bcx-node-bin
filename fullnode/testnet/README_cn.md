# 1. 搭建同步区块节点

## 1.1.	安装环境要求

* 软件要求：Ubuntu 16.04
* 硬件要求：CPU：4核以及上，RAM：16G及以上，硬盘SSD200G以上。
* 运行环境依赖： libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev libtool libcurl4-openssl-dev libboost-all-dev

## 1.2.	安装编译相关的库

* sudo apt-get update
* sudo apt-get install autoconf cmake git vim libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev libtool libcurl4-openssl-dev libboost-all-dev

## 1.3.	获取可执行文件
* 直接通过项目方获取或者下载项目方发布的节点文件witness_node以及命令行终端文件cli_wallet. [下载地址](https://github.com/Cocos-BCX/cocos-bcx-node-bin.git)
* 获取创世区块配置文件[genesis.json](https://github.com/Cocos-BCX/cocos-bcx-node-bin.git)

## 1.4. config.ini配置
* 部分参数修改说明如下:

  * p2p-endpoint: p2p node endpoint, 格式: 0.0.0.0:port, 比如: p2p-endpoint = 0.0.0.0:8060

  * seed-nodes: 设置成出块节点的p2p-endpoint, 格式: ["ip:port"], 比如: seed-nodes = ["39.97.102.65:8060", "39.97.109.131:8060",  "39.105.70.144:8060", "39.97.110.222:8060"]

  * rpc-endpoint: websocket rpc, 需要配置, 格式：0.0.0.0:port, 比如: rpc-endpoint = 0.0.0.0:8049

  * enable-stale-production: 设置为false, 不出块

* 示例:
``` json
        # Endpoint for P2P node to listen on
        # p2p-endpoint =
        p2p-endpoint = 0.0.0.0:14645

        # P2P nodes to connect to on startup (may specify multiple times)
        # seed-node =

        # JSON array of P2P nodes to connect to on startup
        # seed-nodes =
        seed-nodes = ["192.168.90.46:13655"]

        # Pairs of [BLOCK_NUM,BLOCK_ID] that should be enforced as checkpoints.
        # checkpoint =

        # You can use a block number to set a pause point
        # pausepoint =

        # Endpoint for websocket RPC to listen on
        # rpc-endpoint =
        rpc-endpoint = 0.0.0.0:9040

        # Endpoint for TLS websocket RPC to listen on
        # rpc-tls-endpoint =

        # The TLS certificate file for this server
        # server-pem =

        # Password for this certificate
        # server-pem-password =

        # File to read Genesis State from
        # genesis-json =

        # Block signing key to use for init witnesses, overrides genesis file
        # dbg-init-key =

        # JSON file specifying API permissions
        # api-access =

        # Space-separated list of plugins to activate
        # plugins =

        # Enable block production, even if the chain is stale.
        enable-stale-production = false

        # Percent of witnesses (0-99) that must be participating in order to produce blocks
        required-participation = false

        # ID of witness controlled by this node (e.g. "1.6.5", quotes are required, may specify multiple times)
        # witness-id =
        # witness-id = "1.6.1"

        # Tuple of [PublicKey, WIF private key] (may specify multiple times),The owner of the private key is nico
        private-key = ["COCOS7yE9skpBAirth3eSNMRtwq1jYswEE3uSbbuAtXTz88HtbpQsZf","5KAUeN3Yv51FzpLGGf4S1ByKpMqVFNzXTJK7euqc3NnaaLz1GJm”]
```


## 1.5. 节点启动
* 执行: ./witness_node --genesis-json genesis.json, 看到chain-id, ctrl+c终止。

* 修改config.ini配置, 重新执行, 看到如下的log, 说明同步区块节点成功。

``` json
        2128478ms th_a       witness.cpp:84                plugin_initialize    ] witness plugin:  plugin_initialize() begin
        2128478ms th_a       witness.cpp:95                plugin_initialize    ] Public Key: COCOS7yE9skpBAirth3eSNMRtwq1jYswEE3uSbbuAtXTz88HtbpQsZf
        2128478ms th_a       witness.cpp:113               plugin_initialize    ] witness plugin:  plugin_initialize() end
        2128478ms th_a       object_database.cpp:106       open                 ] Opening object database from /home/chukong/xukang/cocos/witness_node_data_dir/blockchain ...
        2128493ms th_a       object_database.cpp:111       open                 ] Done opening object database.
        2128493ms th_a       db_management.cpp:67          reindex              ] reindexing blockchain
        2128493ms th_a       db_management.cpp:73          reindex              ] Replaying blocks, starting at 1975...
        2128494ms th_a       db_management.cpp:133         reindex              ] Done reindexing, elapsed time: 0.00018800000000000 sec
        2128497ms th_a       application.cpp:165           reset_p2p_node       ] Adding seed node 192.168.90.46:13655
        2138499ms th_a       application.cpp:203           reset_p2p_node       ] Configured p2p node to listen on 0.0.0.0:14645
        2138499ms th_a       application.cpp:283           reset_websocket_serv ] Configured websocket rpc to listen on 0.0.0.0:9040
        2138499ms th_a       witness.cpp:118               plugin_startup       ] witness plugin:  plugin_startup() begin
        2138500ms th_a       witness.cpp:136               plugin_startup       ] No witnesses configured! Please add witness IDs and private keys to configuration.
        2138500ms th_a       witness.cpp:138               plugin_startup       ] witness plugin:  plugin_startup() end
        2138500ms th_a       main.cpp:266                  main                 ] Started node on a chain with 1977 blocks.
        2138500ms th_a       main.cpp:267                  main                 ] Chain ID is 62a15350c785c1b12b7590c0398e283fa45f7d5f263eddcb39934a9ffaa3087a
        2138996ms th_a       application.cpp:530           handle_block         ] Got block: #1992 time: 2019-05-30T08:35:39 latency: -3 ms from: cocos-witness-3  irreversible: 1988 (-4)
        2139997ms th_a       application.cpp:530           handle_block         ] Got block: #1993 time: 2019-05-30T08:35:40 latency: -2 ms from: cocos-witness-4  irreversible: 1988 (-5)
        2140998ms th_a       application.cpp:530           handle_block         ] Got block: #1994 time: 2019-05-30T08:35:41 latency: -1 ms from: cocos-witness-1  irreversible: 1988 (-6)
        2141995ms th_a       application.cpp:530           handle_block         ] Got block: #1995 time: 2019-05-30T08:35:42 latency: -4 ms from: cocos-witness-0  irreversible: 1991 (-4)
        2142996ms th_a       application.cpp:530           handle_block         ] Got block: #1996 time: 2019-05-30T08:35:43 latency: -3 ms from: cocos-witness-2  irreversible: 1992 (-4)
        2144002ms th_a       application.cpp:530           handle_block         ] Got block: #1997 time: 2019-05-30T08:35:44 latency: 2 ms from: cocos-witness-1  irreversible: 1993 (-4)
```

## 附:
* 搭建普通出块节点也可以直接执行脚本: [setup_node.sh](https://github.com/Cocos-BCX/cocos-bcx-node-bin.git)
