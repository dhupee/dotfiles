# not only aliases but also functions
# if i think its going to be more cumbersome i'll split it
# TODO: organize the aliases alphabetically

# Clear
alias c="clear"

# NOTE: I dont really think using bat as cat is a good idea
# Bat to Cat if Bat exists
# if [ -e "/bin/bat" ]; then
# 	alias cat="bat"
# fi

# Tmux 256 colors
# alias tmux='TERM=screen-256color tmux'

# Helix
alias hx="helix"
hxf() {
    helix $(fzf)
}

# Copying Tmux.conf to tmate.conf
alias tmux2tmate="cp ~/.tmux.conf ~/.tmate.conf"

# Plasma
alias plasma-restart="kquitapp5 plasmashell ; sleep 2s ; kstart5 plasmashell"

# Git
alias ga="git add"
alias gs="git status"
alias gb='git branch'
alias gl='git log'
alias gcm="git commit -m"
alias gco='git checkout'
alias gpsh="git push"
alias gpll="git pull"

# Goenv
alias goenv-update="cd ~/.goenv && git fetch --all && git pull && cd"

# Bluetooth
alias bt-start="systemctl start bluetooth"
alias bt-stop="systemctl stop bluetooth"

# Qemu/KVM
alias vm-start="systemctl start libvirtd"
alias vm-stop="systemctl stop libvirtd"

# SSH Server
alias ssh-server-start="systemctl start sshd.service"
alias ssh-server-stop="systemctl stop sshd.service"
alias ssh-server-check="nc -v -z 127.0.0.1 22"

# Firewal
alias firewall-start="systemctl start firewalld.service"
alias firewall-stop="systemctl stop firewalld.service"

# LS & LL
alias ls="ls --color='auto'"
alias lsa="ls -a --color='auto'"
alias lla="ll -a"

# NVIM
alias v="vim"
alias nv="nvim"
nvf() {
    nvim $(fzf)
}

# Dotfile save
alias dotsave="sh $HOME/.scripts/dotsave.sh"

# Symlink
alias symlink="ln -s"

# Run osu with dedicated graphics by default
alias osu="DRI_PRIME=1 /usr/bin/osu-lazer"

# Flatpak aliases, tidy up

# Podman is Docker, fight me
# alias docker="podman"

# Arch-based maintenance
alias orphanrm="bash $HOME/.scripts/remove-orphans.sh"
alias orphanrm-aur="yay -Yc"
alias cacherm="rm -rf ~/.cache/*"

# Lazygit
alias lg="lazygit"

# Update Ohmyzsh's custom plugins
alias omz_custom_update="sh $HOME/.scripts/omz-custom-upgrade.sh"

# zoxide as cd
# if command -v zoxide >/dev/null; then
# 	alias cd="z"
# fi

# Tunneling url/localhost
alias tunnel="cloudflared tunnel --url $1"

# copy gitignore to create a similar dockerignore
alias git2dock-ignore="cp $PWD/.gitignore $PWD/.dockerignore"

# backup bottles yml
alias bottles-backup="bash .scripts/bottles-backup.sh"

# nbfc fan control
alias fan-speed-full="sudo nbfc set --speed=100"
alias fan-speed-auto="sudo nbfc set --auto"

# NVM
alias nvm-update="curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)/install.sh" | bash"

# FNM
# alias fnm-update="curl -fsSL https://fnm.vercel.app/install | zsh -s -- --skip-shell"

# Delete X number of latest shell history
function delete_latest_history() {
    # Default count is 1
    local count=${1:-1}
    echo "Deleting last $count shell history entries"
    fc -p -1 | tail -n $count | awk "{print $1}" | xargs -I {} fc -d {}
}

# symlink the fonts directory on dotfile git repo to home
alias fonts-symlink-init="ln -s $HOME/.local/share/chezmoi/dot_fonts $HOME/.fonts"
