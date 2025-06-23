# FZF
alias f="fzf"

# Live-grepping history with fzf
function historygrep() {
    eval $(history -n | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Live-grepping history with fzf but not run it
function historygrep_no_run() {
    history | fzf | sed 's/ *[0-9]* *//'
}
