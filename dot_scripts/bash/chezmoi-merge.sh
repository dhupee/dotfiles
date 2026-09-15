#!/bin/sh
# $1 = Destination (Local)
# $2 = Source (Source state/Repo)
# $3 = Target (Generated/New)

# Copy the destination to a temporary file to safely merge
cp "$1" "$1.tmp"

# Run git's 3-way merge to bake conflict markers into the temporary file
git merge-file "$1.tmp" "$2" "$3"

# Open the unified file in Neovim
nvim "$1.tmp"

# If Neovim exits successfully, overwrite the destination
if [ $? -eq 0 ]; then
  mv "$1.tmp" "$1"
else
  rm "$1.tmp"
  exit 1
fi
