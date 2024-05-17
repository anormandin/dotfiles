# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit package manager initialisation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "${ZINIT_HOME}" ]; then
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS
# Prompt (Powerlevel10k)
zinit ice depth=1; zinit light romkatv/powerlevel10k # prompt

zinit light zsh-users/zsh-syntax-highlighting 
zinit light zsh-users/zsh-completions 
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# SNIPPETS
zinit snippet OMZP::git

# Load completions
autoload -U compinit && compinit

# Keybindings

# Enable Emacs mode
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case-insensitive completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # color completion
zstyle ':completion:*' menu no # disable completion menu

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':completion:*:git-checkout:*' sort false # disable sorting for git checkout
zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # use tmux popup for fzf-tab



# Aliases
alias ls='ls --color=auto'

# Shell integragions
eval "$(fzf --zsh)"  # ^r to search history

# Initialize Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] ||source ~/.p10k.zsh
