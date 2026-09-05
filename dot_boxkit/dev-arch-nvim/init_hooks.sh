#!/bin/bash
set -e

HOST_HOME="/home/$(whoami)"
DISTROBOX_HOME="/home/$(whoami)/.distrobox/dev-arch-nvim"

TARGET_NVIM_DIR="$DISTROBOX_HOME/.config/nvim"
HOST_NVIM_CONFIGS="$HOST_HOME/.local/share/chezmoi/dot_nix-configs/config/nvim"
LOCKS="$HOST_HOME/.local/share/chezmoi/mutable-configs/nvim"

mkdir -p "$TARGET_NVIM_DIR"

ln -sf "$HOST_NVIM_CONFIGS/lua" "$TARGET_NVIM_DIR/lua"
ln -sf "$HOST_NVIM_CONFIGS/init.lua" "$TARGET_NVIM_DIR/init.lua"
ln -sf "$HOST_NVIM_CONFIGS/dot_luarc.json" "$TARGET_NVIM_DIR/.luarc.json"
ln -sf "$HOST_NVIM_CONFIGS/dot_neoconf.json" "$TARGET_NVIM_DIR/.neoconf.json"
ln -sf "$HOST_NVIM_CONFIGS/stylua.toml" "$TARGET_NVIM_DIR/stylua.toml"

ln -sf "$LOCKS/lazy-lock.json" "$TARGET_NVIM_DIR/lazy-lock.json"
ln -sf "$LOCKS/lazyvim.json" "$TARGET_NVIM_DIR/lazyvim.json"

echo 'export PATH=/usr/local/bin:/usr/bin:/bin' >>"$DISTROBOX_HOME/.zshrc"

exec "$@"
