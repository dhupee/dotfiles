#!/bin/bash


bottles_path="${HOME}/.var/app/com.usebottles.bottles/data/bottles/bottles"

# for loop folders in the path
for d in "${bottles_path}"/*; do
    # echo "$d"
    basename="${d##*/}"
    echo "backupping $basename"

    cp -r "$d/bottle.yml" "$HOME/.backup-bottles/$basename.yml"
done
