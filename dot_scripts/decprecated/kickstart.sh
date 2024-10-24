#!/bin/bash

# install the needed programs
curl -fsSL https://raw.githubusercontent.com/dhupee/dotfiles/master/dot_scripts/install-arch.sh | bash

# Clone your dotfiles repository using Chezmoi
chezmoi init --apply dhupee

# Symlink the fonts folder
if [ ! -d ~/.local/share/chezmoi/dot_fonts/ ]; then
    ln -s ~/.local/share/chezmoi/dot_fonts ~/.fonts
fi
