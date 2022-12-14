#!/usr/bin/bash

# my mostly used software
# WARNING: ONLY USE THIS SCRIPT FOR FEDORA

# set the directory to home
cd $HOME

# enable RPM fusion
sudo dnf install \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release

# install stuff from dnf
sudo dnf install -y git-all \
                gnome-tweaks \
                htop \
                podman \
                lutris \
                cmatrix \
                crontab \
                vlc \
                qbittorrent \
                steam \
                zsh

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install pyenv & its prerequisites
curl https://pyenv.run | bash
sudo dnf groupinstall "Development Tools" -y
sudo dnf install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel findutils -y

# install cloudflare-warp
sudo rpm -ivh https://pkg.cloudflareclient.com/cloudflare-release-el8.rpm
sudo sed -i 's/$releasever/8/g' /etc/yum.repos.d/cloudflare.repo
sudo dnf install cloudflare-warp

# install ohmyzsh
chsh -s $(which zsh)
sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install ohmyzsh plugins
git clone https://github.com/zdharma/fast-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

# install ohmyzsh themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# install brave-browser
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser

# install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

#-----------------------------INSTALL FLATPAK------------------------

# install flatpak then enable flathub remote
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install spotify and discord
sudo flatpak install flathub \
    com.spotify.Client \
    com.discordapp.Discord \
    com.usebottles.bottles \
    sh.ppy.osu
    
#---------------INSTALL APPIMAGES AND BINARIES------------------------

# make directory $HOME/Appimages
sudo mkdir -p $HOME/Appimages
cd $HOME/Appimages

# TODO: create for loop if I need more than 1 Appimages
# download Cura
wget https://github.com/Ultimaker/Cura/releases/download/5.2.1/Ultimaker-Cura-5.2.1-linux-modern.AppImage
chmod a+x Ultimaker-Cura-5.2.1-linux-modern.AppImage

if [ ! -d $HOME/Bin ]; then
    echo "No directory, making it"
    mkdir $HOME/Bin
else
    echo "Directory already exist"
fi
cd $HOME/Bin

wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64

#-----------------------------INSTALL RPM FILES------------------------
# also dont forget to update it
cd $HOME
cd /tmp

# download WPS office
wget https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11664/wps-office-11.1.0.11664.XA-1.x86_64.rpm

# install any rpm file I've downloaded
sudo dnf install ./*.rpm

cd $HOME

#-----------------------------INSTALL FEW GIT REPOS--------------------
if [ ! -d $HOME/Tools ]; then
    echo "No directory, making it"
    mkdir $HOME/Tools
else
    echo "Directory already exist"
fi
cd $HOME/Tools

# go back to home and print done
cd $HOME
echo "Installation Done! Please restart to enable changes on the zsh"
