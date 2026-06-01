alias bucc="claude --version && npm install -g @anthropic-ai/claude-code && claude --version"
alias neo="cd ~/Documents/dev.nosync/neosapiens/"
alias vimconfig="nvim ~/.config/nvim/init.lua"

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
alias pmv=' python3 ~/mv.py'

# --- dotfiles / GNU Stow (package: home) ---
alias dot='cd ~/dotfiles'
alias stow-on='stow -v -t ~ -d ~/dotfiles home'      # create/refresh symlinks
alias stow-off='stow -D -v -t ~ -d ~/dotfiles home'  # remove symlinks
alias restow='stow -R -v -t ~ -d ~/dotfiles home'    # re-stow (picks up newly added files)
alias stow-dry='stow -n -v -t ~ -d ~/dotfiles home'  # preview, change nothing
