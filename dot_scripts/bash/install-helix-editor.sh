#!/bin/sh

ARCH="x86_64-linux"
VERSION="24.07"
DOWNLOAD_PATH="/tmp/"
EXTRACT_DIR="/tmp/helix-editor-dhupee"
CONFIG_DIR="$HOME/.config/helix"
BIN_DIR="$HOME/.local/bin"

# Download and extract Helix
wget -P "$DOWNLOAD_PATH" "https://github.com/helix-editor/helix/releases/download/${VERSION}/helix-${VERSION}-${ARCH}.tar.xz"

# if the path doesnt exist simply make it
if [ ! -d $EXTRACT_DIR ]; then
    mkdir $EXTRACT_DIR
fi

# Extracting helix
tar -xvf "${DOWNLOAD_PATH}helix-${VERSION}-${ARCH}.tar.xz" -C "${EXTRACT_DIR}"

# create config directory
if [ ! -d $CONFIG_DIR ]; then
    mkdir $CONFIG_DIR
fi

# create config directory
if [ ! -d $BIN_DIR ]; then
    mkdir $BIN_DIR
fi

# copy things
cp -r "${EXTRACT_DIR}/helix-${VERSION}-${ARCH}/runtime" "${CONFIG_DIR}/runtime"
cp "${EXTRACT_DIR}/helix-${VERSION}-${ARCH}/hx" "${BIN_DIR}/hx"

# exporting the saved path
export PATH=$PATH:~/.local/bin/
