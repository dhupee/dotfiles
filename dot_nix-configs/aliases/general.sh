# not only aliases but also functions
# if i think its going to be more cumbersome i'll split it

# Clear
alias c="clear"

# # Helix
# alias hx="helix"
hxf() {
  hx $(fzf)
}

# yazi
alias y="yazi"

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

# Quick URL shortener
shorten_url() {
  if [ -z "$1" ]; then
    echo "Usage: shorten_url <url>"
    return 1
  fi
  curl -s "https://tinyurl.com/api-create.php?url=$1"
}
