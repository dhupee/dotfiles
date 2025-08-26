# FZF
alias f="fzf"

# Live-grepping history with fzf
function hg() {
	eval $(history -n | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Live-grepping history with fzf but not run it
function hgd() {
	history | fzf | sed 's/ *[0-9]* *//'
}

cdf() {
	# Check if fd is installed
	if ! command -v fd &>/dev/null; then
		echo "Error: 'fd' is not installed. Please install fd to use this function."
		echo "You can install it from: https://github.com/sharkdp/fd"
		return 1
	fi

	# Check if fzf is installed
	if ! command -v fzf &>/dev/null; then
		echo "Error: 'fzf' is not installed. Please install fzf to use this function."
		echo "You can install it from: https://github.com/junegunn/fzf"
		return 1
	fi

	local dir
	dir=$(fd --type d --hidden --exclude .git 2>/dev/null | fzf --height 40% --reverse) &&
		cd "$dir"
}
