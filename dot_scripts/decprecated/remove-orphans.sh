#!/usr/bin/bash

# List all orphaned packages
orphans=$(pacman -Qdtq)

# If there are no orphaned packages, exit
if [[ -z "$orphans" ]]; then
  echo "No orphaned packages."
  exit 0
fi

# Count number of orphaned packages
count=$(echo "$orphans" | wc -l)

# Print list of orphaned packages with count
echo "There are $count orphaned packages:"
echo "$orphans"

# Prompt user to remove orphaned packages
read -p "Do you want to remove these packages? [y/N] " choice

# Default to N(no)
case "$choice" in
  y|Y )
    # Remove orphaned packages
    sudo pacman -Rns $orphans
    ;;
  * )
    echo "Package removal cancelled."
    exit 0
    ;;
esac
