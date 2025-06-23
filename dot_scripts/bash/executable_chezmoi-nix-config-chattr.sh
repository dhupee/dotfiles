#!/bin/sh

# Ensure CHEZMOI_WORKING_TREE is set
if [ -z "$CHEZMOI_WORKING_TREE" ]; then
	echo "CHEZMOI_WORKING_TREE is not set."
	exit 1
fi

# Define the target directory
TARGET_DIR="$CHEZMOI_WORKING_TREE/private_dot_nix-configs"

# Check if the directory exists
if [ -d "$TARGET_DIR" ]; then
	# Run the chezmoi chattr command
	chezmoi chattr --recursive -- -private "$HOME/.nix-configs"
# else
# 	echo "Directory $TARGET_DIR does not exist. Skipping command."
fi
