[中文](https://github.com/Cocos-BCX/cocos-bcx-node-bin/tree/master/fullnode/README_cn.md "中文")

# 1. Set up block syncing node

## 1.1.	Installation environment requirements

* Software: Ubuntu 16.04
* Hardware: CPU: 4 cores or above, RAM: 16G or above, hard disk SSD200G or above.
* Runtime environment: libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev libtool libcurl4-openssl-dev libboost-all-dev

## 1.2.	Install compilation related libraries

* sudo apt-get update
* sudo apt-get install autoconf cmake git vim libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev libtool libcurl4-openssl-dev libboost-all-dev

## 1.3.	Get the executables
* Get or download the node file witness_node and the command line terminal file cli_wallet released by the project directly. [Download address](https://github.com/Cocos-BCX/cocos-bcx-node-bin.git)
* •	Get the configuration file of genesis block[genesis.json](https://github.com/Cocos-BCX/cocos-bcx-node-bin.git)

## 1.4. config.ini
* •	Some parameters are modified as follows:

  * p2p-endpoint: p2p node endpoint, format: 0.0.0.0:port, for example: p2p-endpoint = 0.0.0.0:8060

  * seed-nodes: set to p2p-endpoint of the block node, format: ["ip:port"], for example: seed-nodes = ["39.97.102.65:8060", "39.97.109.131:8060", "39.105.70.144:8060", "39.97.110.222:8060"]

  * o	rpc-endpoint: websocket rpc, needs to be configured, format: 0.0.0.0:port, for example: rpc-endpoint = 0.0.0.0:8049

  * enable-stale-pket to false to generate no block

* Example:
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


## 1.5. Node start
* Execute: ./witness_node --genesis-json genesis.json to see the chain-id, press ctrl+c to terminate.

* Change the config.ini to re-execute, after which you will see the following log, indicating that the block nodes syncing is successful.

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

## Note:
* You can also execute the script directly by setting up a regular block node: [setup_node.sh](https://github.com/Cocos-BCX/cocos-bcx-node-bin/blob/master/fullnode/testnet/v0.7.17/config/setup_node.sh)

### mainnet  
Make sure the chain-id is:   ``` 6057d856c398875cac2650fe33caef3d5f6b403d184c5154abbff526ec1143c4   ```,    
When you run: 
  ``` ./witness_node --genesis-json genesis.json ```

### testnet  

Make sure the chain-id is:   ``` 1ae3653a3105800f5722c5bda2b55530d0e9e8654314e2f3dc6d2b010da641c5   ```,    
When you run: 
  ``` ./witness_node --genesis-json genesis.json ```

