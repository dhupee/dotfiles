# not only aliases but also functions
# if i think its going to be more cumbersome i'll split it

# Clear
alias c="clear"

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

# Qemu/KVM
alias vm-start="systemctl start libvirtd"
alias vm-stop="systemctl stop libvirtd"

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
alias dotsave="sh $HOME/.scripts/bash/dotsave.sh"

# Symlink
alias symlink="ln -s"

# Lazygit
alias lg="lazygit"

# Lazydocker
alias lzd="lazydocker"

# Distrobox
alias dtui="distrobox-tui"

# Tunneling url/localhost
alias tunnel="cloudflared tunnel --url $1"

# backup bottles yml
alias bottles-backup="bash $HOME/.scripts/bash/bottles-backup.sh"

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
