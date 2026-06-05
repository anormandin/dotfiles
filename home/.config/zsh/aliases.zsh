alias neo="cd ~/Documents/dev.nosync/neosapiens/"
alias vimconfig="nvim ~/.config/nvim/init.lua"
# SSH into archdev. With an MCM worktree name (e.g. green), also tunnel that
# worktree's Vite client port, so the site opens on the Mac at http://localhost:<port>
# while the session stays open. Port is read live from the worktree's .env.local.
archdev() {
  local wt="$1"
  if [[ -z "$wt" ]]; then
    ssh anormandin@archdev
    return
  fi
  local port
  port=$(ssh anormandin@archdev "grep -hE '^VITE_CLIENT_PORT=' ~/dev/w/MCM/$wt/Frontend/mcm.client/.env.local 2>/dev/null | cut -d= -f2")
  if [[ -z "$port" ]]; then
    echo "archdev: no VITE_CLIENT_PORT for worktree '$wt' (~/dev/w/MCM/$wt)" >&2
    return 1
  fi
  echo "→ http://localhost:${port}  (archdev $wt · Vite) — keep this session open"
  ssh -L "${port}:localhost:${port}" anormandin@archdev
}

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
alias md='glow -p'  # render markdown in a TUI pager

# --- dotfiles / GNU Stow (package: home) ---
alias dot='cd ~/dotfiles'
alias stow-on='stow -v -t ~ -d ~/dotfiles home'      # create/refresh symlinks
alias stow-off='stow -D -v -t ~ -d ~/dotfiles home'  # remove symlinks
alias restow='stow -R -v -t ~ -d ~/dotfiles home'    # re-stow (picks up newly added files)
alias stow-dry='stow -n -v -t ~ -d ~/dotfiles home'  # preview, change nothing
