#!/bin/sh

# Ensure ~/.local/bin is in PATH and at the beginning
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    export PATH="$HOME/.local/bin:$PATH"

    # Add to the appropriate shell configuration file
    if [ -n "$ZSH_VERSION" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.zshrc"
    else
        echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.profile"
    fi
fi

# Target path for the software
TARGET=$HOME/.local/bin/nix-portable

# Create .local/bin directory if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Download the package
curl -L "https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m)" -o "$TARGET"

# Make it executable
chmod +x "$TARGET"
