#!/usr/bin/bash

# Installing build dependencies for pyenv with deps for different OS


# These dependencies based on https://github.com/pyenv/pyenv/wiki#suggested-build-environment
function install_deps_ubuntu() {
    sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

function install_deps_fedora() {
   sudo dnf install make gcc patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-libs libnsl2
}

function install_deps_arch() {
   sudo pacman -S --needed base-devel openssl zlib xz tk
}

# Forever loop for asking which OS
invalid_option=false
while true; do
  if [ "$invalid_option" = true ]; then
    echo "Invalid option, please select a valid option"
    echo ""
  fi

  invalid_option=false

  # Print the choices
  echo "Which OS base is your choice?"
  echo "[1] Ubuntu/Debian"
  echo "[2] Fedora"
  echo "[3] Arch"
  echo "[0] Exit"

  read -p "Select an option [1-3] " os

  # Install dependencies based on the choice
  case $os in
    [1]* ) echo "Installing build dependencies for Ubuntu/Debian" && install_deps_ubuntu; break;;
    [2]* ) echo "Installing build dependencies for Fedora" && install_deps_fedora; break;;
    [3]* ) echo "Installing build dependencies for Arch" && install_deps_arch; break;;
    [0]* ) exit;;
    * ) invalid_option=true;;
  esac
done

