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

# # Helix
# alias hx="helix"
hxf() {
	hx $(fzf)
}

# Copying Tmux.conf to tmate.conf
alias tmux2tmate="cp ~/.tmux.conf ~/.tmate.conf"

# yazi
alias y="yazi"

# Plasma
alias plasma-restart="kquitapp5 plasmashell ; sleep 2s ; kstart5 plasmashell"

# Goenv
alias goenv-update="cd ~/.goenv && git fetch --all && git pull && cd"

# Qemu/KVM
alias vm-start="systemctl start libvirtd"
alias vm-stop="systemctl stop libvirtd"

# # SSH Server
# alias ssh-server-start="systemctl start sshd.service"
# alias ssh-server-stop="systemctl stop sshd.service"
# alias ssh-server-check="nc -v -z 127.0.0.1 22"

# # Firewal
# alias firewall-start="systemctl start firewalld.service"
# alias firewall-stop="systemctl stop firewalld.service"

alias check-local-ip="ip a | grep 'inet ' | grep -v '127.0.0.1'"

# LS & LL
alias ls="ls --color='auto'"
alias lsa="ls -a --color='auto'"
alias ll="ls -l --color='auto'"
alias lla="ls -la --color='auto'"

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

# Lazygit
alias lg="lazygit"

# Lazydocker
alias lzd="lazydocker"

# Tunneling url/localhost
alias tunnel="cloudflared tunnel --url $1"

# copy gitignore to create a similar dockerignore
alias git2dock-ignore="cp $PWD/.gitignore $PWD/.dockerignore"

# backup bottles yml
alias bottles-backup="bash .scripts/bottles-backup.sh"

# nbfc fan control
alias fan-speed-full="sudo nbfc set --speed=100"
alias fan-speed-auto="sudo nbfc set --auto"

# Delete X number of latest shell history
function delete_latest_history() {
	# Default count is 1
	local count=${1:-1}
	echo "Deleting last $count shell history entries"
	fc -p -1 | tail -n $count | awk "{print $1}" | xargs -I {} fc -d {}
}

# Quick URL shortener
shorten_url() {
    if [ -z "$1" ]; then
        echo "Usage: shorten_url <url>"
        return 1
    fi
    curl -s "https://tinyurl.com/api-create.php?url=$1"
}
