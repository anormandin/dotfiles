alias bucc="npm install -g @anthropic-ai/claude-code"
alias neo="cd ~/Documents/dev.nosync/neosapiens/"
alias vimconfig="nvim ~/.config/nvim/init.vim"

# Better ls
alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias tree='eza --tree --icons'

compdef eza=ls

# Utilities
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
