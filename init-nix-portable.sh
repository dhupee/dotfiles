#!/bin/sh

TARGET=$HOME/.local/bin/nix-portable

if [ ! -d $HOME/.local/bin ]; then
    mkdir $HOME/.local/bin
fi

curl -L https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m) >$TARGET

# if .nix-portable is not executable, make it executable
if [ ! -x ./nix-portable ]; then
    chmod +x $TARGET
fi
