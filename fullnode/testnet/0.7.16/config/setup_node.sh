##########################################################################
##########################################################################

        sudo apt-get update

        sudo apt-get install autoconf cmake git vim libbz2-dev libdb++-dev libdb-dev libssl-dev openssl libreadline-dev libtool libcurl4-openssl-dev libboost-all-dev -y

        nohup ./witness_node --genesis-json genesis.json > chainID.log 2>&1 &

        sleep 1

        ps -ef | grep witness_node | grep -v grep | cut -c 9-15 | xargs kill -9

        sed -i 's/# p2p-endpoint = /p2p-endpoint = 0.0.0.0:8060/g' witness_node_data_dir/config.ini

        sed -i 's/# seed-nodes = /seed-nodes = ["39.97.102.65:8060", "39.97.109.131:8060",  "39.105.70.144:8060", "39.97.110.222:8060"]/g' witness_node_data_dir/config.ini

        sed -i 's/# rpc-endpoint = /rpc-endpoint = 0.0.0.0:8049/g' witness_node_data_dir/config.ini

        nohup ./witness_node > node.log 2>&1 &









   printf "\n\n${bldred}\t                                                                 \n"
   printf '\t   ______                                              ____     ______   _  __\n'
   printf "\t  / ____/  ____     _____   ____     _____            / __ )   / ____/  | |/ /\n"
   printf "\t / /      / __ \   / ___/  / __ \   / ___/  ______   / __  |  / /       |   / \n"
   printf "\t/ /___   / /_/ /  / /__   / /_/ /  (__  )  /_____/  / /_/ /  / /___    /   |  \n"
   printf "\t\____/   \____/   \___/   \____/  /____/           /_____/   \____/   /_/|_|  \n"
   printf "\t                                                                              \n${txtrst}"
