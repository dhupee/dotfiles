#!/bin/bash

# LIST OF ESSENTIAL PROGRAMS TO INSTALL FROM PACMAN

## Note:
# 'cli_pacman_programs' is CLI only, make sure of that.
# SEPERATE GUI AND CLI APPS!!!!
# use flatpak for any sandbox software, like bottles

# LIST OF CLI PROGRAMS TO INSTALL FROM PACMAN
cli_pacman_programs=(
    age
    bat
    btop
    cmatrix
    distrobox
    dust
    fastfetch
    fzf
    github-cli
    git-lfs
    go
    htop
    helix
    lazygit
    openssh
    nvtop
    p7zip
    podman
    ranger
    rmlint
    tectonic
    tldr
    thefuck
    tmate
    tmux
    unrar
    yt-dlp
    zsh
    zoxide
)

# LIST OF GUI PROGRAMS TO INSTALL FROM PACMAN, OR A PROGRAM THAT ONLY NEEDED WHEN HAS DESKTOP
gui_pacman_programs=(
    adobe-source-han-sans-jp-fonts
    discord
    fcitx5-configtool
    fcitx5-im
    fcitx5-mozc
    filelight
    flatpak
    gamemode
    gparted
    inkscape
    kicad
    kio-gdrive
    lib32-gamemode
    libreoffice
    lutris
    mpv
    noto-fonts-emoji
    obs-studio
    prusa-slicer
    qemu-desktop
    steam
    ttf-jetbrains-mono-nerd
    ttf-hack-nerd
    virt-manager
    vlc
    v4l2loopback-dkms
    wl-clipboard
    xwaylandvideobridge
)

# LIST OF CLI PROGRAMS TO INSTALL FROM AUR USING YAY
cli_aur_programs=(
    arduino-cli
    cloudflare-warp-bin
    gpsbabel
    nbfc-linux
    ngrok
    ttyper
)

# LIST OF GUI PROGRAMS TO INSTALL FROM AUR USING YAY
gui_aur_programs=(
    ani-cli
    betterdiscordctl
    botflix-git
    brave-bin
    heroic-games-launcher-bin
    konsave
    kwin-polonium
    lobster-git
    mov-cli-git
    osu-lazer-bin
    podman-desktop-bin
    spicetify-cli
    spotify-adblock
    vscodium
)

flatpak_programs=(
    com.usebottles.bottles
    com.playonlinux.PlayOnLinux4
    org.openscad.OpenSCAD
)

# List of custom Ohmyzsh plugins
custom_ohmyzsh_plugins=(
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/marlonrichert/zsh-autocomplete.git"
)

# Placeholder for unused omz plugins
# "https://github.com/zsh-users/zsh-history-substring-search"

# FUNCTION TO INSTALL PROGRAMS FROM PACMAN AND AUR
install_programs_pacman() {
    # INSTALL THE PROGRAMS FROM PACMAN
    sudo pacman -S --noconfirm "$@"
    if [ $? -ne 0 ]; then
        echo "Failed to install some programs from pacman. Skipping."
    fi
}

install_programs_aur() {
    # INSTALL THE PROGRAMS FROM AUR USING YAY
    yay -S --needed --noconfirm "$@"
    if [ $? -ne 0 ]; then
        echo "Failed to install some programs from AUR. Skipping."
    fi
}

# CHECK IF YAY (AUR HELPER) IS INSTALLED, IF NOT, INSTALL IT
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    if ! sudo pacman -S --needed --noconfirm git base-devel; then
        echo "Failed to install prerequisites for yay. Skipping."
    fi

    # CLONE YAY REPOSITORY FROM AUR AND INSTALL WITHOUT SUDO
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmp_dir"
    (cd "$tmp_dir" && makepkg -si --noconfirm)
    rm -rf "$tmp_dir"
fi
wait

# UPDATE PACKAGE DATABASE
echo "Updating package database..."
if ! sudo pacman -Sy; then
    echo "Failed to update package database. Skipping."
fi
wait

# CHECK IF --cli-only FLAGS IS PROVIDED
install_gui_programs=true
if [[ "$1" == "--cli-only" ]]; then
    install_gui_programs=false
    shift
fi
wait

# TODO: add seperate if function for AUR, and check if AUR is needed

# INSTALL PACMAN PROGRAMS
install_programs_pacman "${cli_pacman_programs[@]}"
if $install_gui_programs; then
    install_programs_pacman "${gui_pacman_programs[@]}"
fi
wait

# INSTALL AUR PROGRAMS WITH YAY
install_programs_aur "${cli_aur_programs[@]}"
if $install_gui_programs; then
    install_programs_aur "${gui_aur_programs[@]}"
fi
wait

# INSTALL SOFTWARE WITH FLATPAK
if $install_gui_programs; then
    flatpak install -y flathub "${flatpak_programs}"
fi
wait

# INSTALL OHMYZSH
echo "Installing Ohmyzsh..."
if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --skip-chsh; then
    echo "Ohmyzsh installed successfully."
else
    echo "Failed to install Ohmyzsh. Skipping."
fi
wait

# INSTALL CUSTOM OHMYZSH PLUGINS USING A FOR LOOP
for plugin in "${custom_ohmyzsh_plugins[@]}"; do
    echo "Cloning plugin: ${plugin}"
    if git clone --depth 1 "$plugin" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$(basename "$plugin" .git)"; then
        echo "Plugin cloned successfully."
    else
        echo "Failed to clone plugin: ${plugin}"
    fi
done
wait

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
wait

# INSTALL GOENV
echo "Installing Goenv..."
if git clone https://github.com/go-nv/goenv.git ~/.goenv; then
    echo "Goenv installed successfully."
else
    echo "Failed to install Goenv. Skipping."
fi
wait

# INSTALL NVM
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)/install.sh" | bash
wait

# # INSTALL FNM
# echo "Installing FNM"
# if curl -fsSL https://fnm.vercel.app/install | bash; then
#     echo "FNM installed successfully."
# else
#     echo "Failed to install FNM. Skipping."
# fi
# wait

# INSTALL PYENV
echo "Installing pyenv..."
if curl https://pyenv.run | bash; then
    echo "pyenv installed successfully."
else
    echo "Failed to install pyenv. Skipping."
fi
wait

## INSTALL FLY.IO
# echo "Installing Fly.io..."
# if curl -L https://fly.io/install.sh | sh; then
#     echo "Fly.io installed successfully."
# else
#     echo "Failed to install Fly.io. Skipping."
# fi
# wait

# INSTALL PLATFORMIO CORE CLI
curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
python3 get-platformio.py
wait
mkdir -p /usr/local/bin/
sudo ln -s ~/.platformio/penv/bin/platformio /usr/local/bin/platformio
sudo ln -s ~/.platformio/penv/bin/pio /usr/local/bin/pio
sudo ln -s ~/.platformio/penv/bin/piodebuggdb /usr/local/bin/piodebuggdb
wait

# CHANGE PERMISSION OF SPICETIFY, ACCORDING TO DOCS
if [ -d "/opt/spotify" ]; then
    sudo chmod a+wr /opt/spotify
    sudo chmod a+wr /opt/spotify/Apps -R
    echo "Permissions changed successfully."
else
    echo "Directory /opt/spotify does not exist."
fi
wait

echo "All programs have been installed successfully!"

# CHANGE THE DEFAULT SHELL TO ZSH
echo "Change default shell to zsh..."
sudo chsh -s $(which zsh)
wait
