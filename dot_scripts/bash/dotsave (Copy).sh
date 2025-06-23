#!/usr/bin/bash

# status: operational

rclone_remote="mega-dh"

dir_array=(
    "$HOME/.backup-bottles/"
    "$HOME/.scripts/"
    "$HOME/.config/htop/"
    "$HOME/.config/btop/"
    "$HOME/.config/neofetch/"
    "$HOME/.completion_zsh/"
    "$HOME/.config/nvim/"
    "$HOME/.config/ohmyposh/"
    "$HOME/.config/PrusaSlicer/"
    "$HOME/.config/obs-studio/basic/"
    "$HOME/.config/containers/"
    "$HOME/.aliases/"
    "$HOME/.config/helix/"
    "$HOME/.config/BetterDiscord/plugins/"
    "$HOME/.config/BetterDiscord/themes/"
    "$HOME/.config/lobster/"
    "$HOME/.config/alacritty/"
    "$HOME/.config/zellij/"
    "$HOME/.config/mov-cli/"
    "$HOME/.config/VSCodium/User/snippets/"
)

# commented dirs and files
# "$HOME/.fonts/"
# "$HOME/Wallpapers/"

file_array=(
    "$HOME/.zshrc"
    "$HOME/.zshrc.pre-oh-my-zsh"
    "$HOME/.gitconfig"
    "$HOME/.p10k.zsh"
    "$HOME/.bashrc"
    "$HOME/.nanorc"
    "$HOME/.fonts.conf"
    "$HOME/.tmux.conf"
    "$HOME/.tmate.conf"
    "$HOME/.config/spicetify/config-xpui.ini"
    "$HOME/.config/obs-studio/global.ini"
    "$HOME/.config/chezmoi/chezmoi.toml"
    "$HOME/.config/VSCodium/User/settings.json"
    "$HOME/.config/VSCodium/User/keybindings.json"
    "$HOME/.codium-extensions.txt"
)

encrypted_dir_array=(
    "$HOME/.ssh/"
    "$HOME/.config/qBittorrent/"
)

encrypted_file_array=(
    "$HOME/.github-cli-token"
    "$HOME/.config/ngrok/ngrok.yml"
    "$HOME/.config/rclone/rclone.conf"
)

#----------------------BACKUP VSCODIUM EXTENSION LIST-------------

codium --list-extensions >$HOME/.codium-extensions.txt

#----------------------SAVING FILES AND DIRS----------------------

for d in "${dir_array[@]}"; do
    if [ -d $d ]; then
        # echo "$d exists"
        echo "adding $d"
    else
        echo "$d is not exists"
        read -p "Would you like to make one? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, creating directory $d" && mkdir $d ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac

    fi
    chezmoi add $d
done

for f in "${file_array[@]}"; do
    if [ -f $f ]; then
        echo "adding $f"
    else
        echo "$f is not exists"
        echo ""
    fi

    chezmoi add $f
done

#-----------------ENCRYPTING AND ADDING DIRS AND FILES---------------------

for d in "${encrypted_dir_array[@]}"; do
    if [ -d $d ]; then
        # echo "$d exists"
        echo "adding and encrypting $d"
    else
        echo "$d is not exists"
        read -p "Would you like to make one? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, creating directory $d && mkdir $d" ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac

    fi
    chezmoi add --encrypt $d
done

for f in "${encrypted_file_array[@]}"; do
    if [ -f $f ]; then
        echo "adding and encrypting $f"
    else
        echo "$f is not exists"
        echo ""
    fi

    chezmoi add --encrypt $f
done

echo " "

#---------------------------COPYING NIXOS----------------------
# if [ -d /etc/nixos/ ]; then
#     cp -r /etc/nixos $HOME/.local/share/chezmoi/nixos/dhupee
#     echo "copying nixos config"
# fi

chezmoi add "$HOME/nixos-config"

#---------------------------COMMIT TO GIT----------------------

# pushing to github
cd $HOME/.local/share/chezmoi
git add .
# git commit -m "automated update by dhupee"
git commit -m "automated update by dhupee, at $(date +'%H:%M %d/%m/%Y')"
git push
sleep 3

# Backup qbittorrent's torrent
echo " "
echo "backupping qbittorrent's data to mega"
# rclone delete $rclone_remote:akago/.config/transmission/
rclone copy "$HOME/.local/share/qBittorrent/" $rclone_remote:akago/.local/share/qBittorrent/ -P

# if no-konsave flag then dont save konsave profiles
if [ "$1" != "--no-rclone" ]; then
    # pushing the big files to mega
    echo " "
    echo "Pushing konsave profiles to Mega"

    # NOTE: make sure to have same folder name, I want to try automate the backup method

    # Saving konsave profiles
    # rclone delete $rclone_remote:akago/konsave-profiles/
    rclone copy "$HOME/.konsave-profiles/" $rclone_remote:akago/.konsave-profiles/ -P

    # MAKE THIS FOR VERY HUGE STORAGE
    # if folder lazerexport exist, ask to backup or not
    # don't delete, append since the contain of the beatmap didn't change like others
    if [ -d "$HOME/lazerexport/" ]; then
        read -p "Would you like to backup lazerexport folder? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, backing up lazerexport folder" && rclone copy "$HOME/lazerexport/" mega-dh:akago/lazerexport/ -P ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac

        # ask to delete lazerexport locally
        read -p "Would you like to delete lazerexport folder? (y/n)?" choice
        case "$choice" in
        y | Y) echo "yes, deleting lazerexport folder" && rm -rf "$HOME/lazerexport/" ;;
        n | N) echo "skipping" ;;
        *) echo "choice is invalid" ;;
        esac
    fi
fi
