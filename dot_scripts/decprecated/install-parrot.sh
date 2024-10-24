#!bin/bash

# should work for any debian based as well

deb_programs=(
    zsh
    git-lfs
    htop
    tldr
    fzf
    thefuck
    micro
	flatpak
	parrot-desktop-kde
)

flatpak_programs=(
	com.brave.Browser
	com.visualstudio.code
	io.github.shiftey.Desktop
)

# List of custom Ohmyzsh plugins
custom_ohmyzsh_plugins=(
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"
    "https://github.com/zsh-users/zsh-autosuggestions.git"
    "https://github.com/marlonrichert/zsh-autocomplete.git"
    "https://github.com/zsh-users/zsh-history-substring-search"
)

sudo apt update && sudo apt upgrade -y
wait

# install programs from the debian repo
echo "Installing programs..."
for program in "${deb_programs[@]}"; do
    if sudo apt install -y "$program"; then
        echo "$program installed successfully."
    else
        echo "Failed to install $program. Skipping."
    fi
done
wait

# add flathub repo
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
wait

# INSTALL SOFTWARE WITH FLATPAK
flatpak install -y flathub "${flatpak_programs}"
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

# INSTALL GOBREW
echo "Installing Gobrew..."
if curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh; then
    echo "Gobrew installed successfully."
else
    echo "Failed to install Gobrew. Skipping."
fi
wait

# INSTALL NVM
echo "Installing nvm..."
if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash; then
    echo "nvm installed successfully."
else
    echo "Failed to install nvm. Skipping."
fi
wait

# INSTALL PYENV
echo "Installing pyenv..."
if curl https://pyenv.run | bash; then
    echo "pyenv installed successfully."
else
    echo "Failed to install pyenv. Skipping."
fi
wait

# CHANGE THE DEFAULT SHELL TO ZSH
echo "Change default shell to zsh..."
sudo chsh -s $(which zsh)
wait

# Clone your dotfiles repository using Chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.bin
sleep 3
./.bin/chezmoi init --apply dhupee
