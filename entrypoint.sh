#!/bin/bash

CONFIG_PATH="/opt/writefreely/config.ini"
BIN_PATH="/opt/writefreely/writefreely"

cd /opt/writefreely

if ! command -v wget >/dev/null 2>&1; then
    echo "Installing wget."
    apt update && apt install wget -y
fi

if [ ! -f "$BIN_PATH" ]; then
    echo "Writefreely bin not found, downloading."
    
    if [ -z "$VERSION" ]; then
        echo "Version is not set, cannot download writefreely. Exiting."
        exit 1
    fi
    cd /tmp
    wget https://github.com/writefreely/writefreely/releases/download/v${VERSION}/writefreely_${VERSION}_linux_amd64.tar.gz
    tar -xf /tmp/writefreely_${VERSION}_linux_amd64.tar.gz -C /opt/
    
    cd /opt/writefreely
fi
    

if [ ! -f "$CONFIG_PATH" ]; then
    echo "Config '$CONFIG_PATH' does not exist, creating default configuration."

    ./writefreely --create-config
    ./writefreely keys generate
fi

./writefreely

