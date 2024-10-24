#!/bin/bash

# STATUS: OPERATIONAL

THEME_DIR="$HOME/.oh-my-zsh/custom/themes"
PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"

# for loop folders in the path
for dir  in "$THEME_DIR" "$PLUGINS_DIR"; do
    # find any folder in the path
    for folder in "$dir"/*; do
        # echo $folder
        # if .git in the folder exists then fetch and pull
        if [ -d "$folder/.git" ]; then
            # echo ".git in $folder exists"
            cd "$folder"
            git fetch origin && git pull
        fi
    done
done
