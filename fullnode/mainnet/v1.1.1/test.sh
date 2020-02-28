#!/bin/sh
#
# boot.sh
# Author cocosbcx<dev@cocosbcx.io>
#
# Distributed under terms of the LGPLv3 license.
#

set -ue
PREFIX=${PREFIX:="/mnt/witness"}
VERSION=${VERSION:="v1.1.1"}
CURL="curl -fsSL"
PYTHON=${PYTHON:=python}
USR_LOCAL_BIN=${USR_LOCAL_BIN:=/usr/local/bin}
export PATH=$PATH:$USR_LOCAL_BIN
#
# function
#
_SYS_MIN_CPU=2          # 2 cpu
_SYS_REC_CPU=4          # 4 cpu
_SYS_MIN_MEM=8          # 8G ram
_SYS_REC_MEM=16         # 16G ram
_SYS_MIN_STO=200        # 200G storage
_SYS_REC_STO=1000       # 1T storage

print_requirements() {
    {
        printf "\nWarning: please consider upgrading your hardware to get better performance."
        printf "\n"
        printf "\nSystem requirements to run IOST node:\n\n"
        printf "\tMinimal: \t$_SYS_MIN_CPU cpu / ${_SYS_MIN_MEM}G ram / ${_SYS_MIN_STO}G storage\n"
        printf "\tRecommended: \t$_SYS_REC_CPU cpu / ${_SYS_REC_MEM}G ram / ${_SYS_REC_STO}G storage\n"
        printf "\n"
    }>&2
}

print_minimal_fail() {
    {
        echo Minimal requirements not satisfied. Stopped.
    }>&2
    return 1
}

install_docker() {
    $CURL https://get.docker.com | sudo sh
    {
        echo
        echo Make sure \`docker\` is prepared and then re-run the boot script.
        echo
    }>&2
    return 1
}
install_docker_compose() {
    _SYS=$(uname)
    if [ x$_SYS = x"Linux" ]; then
        >&2 echo Installing docker-compose ...
        sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o $USR_LOCAL_BIN/docker-compose
        sudo chmod +x $USR_LOCAL_BIN/docker-compose
        docker-compose version >/dev/null && return 0
    fi
    >&2 echo Install docker-compose failed. See https://docs.docker.com/compose/install/.
    return 1
}


pre_check() {
    curl --version &>/dev/null
   ${PYTHON} -V &>/dev/null || { >&2 echo "Python not found. You might need to set '$PYTHON' manually."; return 1; }
    docker version &>/dev/null || install_docker
    docker-compose version &>/dev/null || install_docker_compose    
    
}

init_prefix() {
    if [ -d "$PREFIX" ]; then
        {
            echo '#########################################'
            echo '########         WARNING         ########'
            echo '#########################################'
            echo Warning: path \"$PREFIX\" exists\; this script will remove it.
            echo You may press Ctrl+C now to abort this script.
        }>&2
        ( set -x; sleep 20 )
    fi
    ( set -x; sudo rm -rf $PREFIX)
    sudo mkdir -p $PREFIX/{logs,config}
    sudo chown -R $(id -nu):$(id -ng) $PREFIX
    cd $PREFIX
}

do_system_check() {
}




#
# main
#

pre_check
init_prefix
#do_system_check

$CURL "https://raw.githubusercontent.com/Cocos-BCX/cocos-bcx-node-bin/master/fullnode/mainnet/$VERSION/config/genesis.json" -o $PREFIX/config/genesis.json
$CURL "https://raw.githubusercontent.com/Cocos-BCX/cocos-bcx-node-bin/master/fullnode/mainnet/$VERSION/config/config.ini" -o $PREFIX/config/config.ini

#
# Build compose file
#

cat <<EOF >docker-compose.yml
version: "2.2"
services:
  witness:
    image: cocosbcx/cocos-mainnet:latest
    container_name: witness
    restart: unless-stopped
    ports:
      - "8049-8050:8049-8050"
    volumes:
      - $PREFIX/COCOS_BCX_DATABASE:/root/witness/COCOS_BCX_DATABASE
      - $PREFIX/config:/root/witness/config
      - $PREFIX/logs:/root/witness/logs
    ulimits:
      nofile: 51200
EOF
docker-compose pull
docker-compose up -d
