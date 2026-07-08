# Initialize ARM64 Homebrew (must come first to prioritize over x86_64)
if [ -f /opt/homebrew/bin/brew ]; then
  # Prepend ARM64 Homebrew to PATH to ensure it takes priority over /usr/local
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# -------------------- History ----------------------
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
HIST_STAMPS="yyyy- mm-dd"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# -------------------- Shell behaviour ----------------------
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  #sort file10 after file9

# -------------------- ZOxide ----------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# -------------------- Completions ----------------------
# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Completion case sensitivity
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # like smartcase in nvim

# fuzzy finder key-bindings + completion (install path differs per platform)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  # macOS (Homebrew)
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  # Linux (Arch package)
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  # Linux (Debian/Ubuntu package)
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# -------------------- Modular config files ----------------------
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/bindings.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/prompt.zsh"



#export ZSH=/Users/alainnormandin/.oh-my-zsh
#ZSH_THEME="robbyrussell"

#ENABLE_CORRECTION="false"
#DISABLE_CORRECTION="true"

# Disable automatic updates check (speeds up startup)
#DISABLE_AUTO_UPDATE="true"
#DISABLE_UPDATE_PROMPT="true"

# Skip verification of insecure directories (speeds up startup)
#ZSH_DISABLE_COMPFIX="true"

# Skip git status checks in prompts (massive speedup in large repos)
# DISABLE_UNTRACKED_FILES_DIRTY="true"


# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git docker colored-man-pages colorize brew osx zsh-syntax-highlighting zsh-autosuggestions)
#plugins=(git)

#source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"


export PYTHONDONTWRITEBYTECODE=1

DEFAULT_USER=`whoami`

export MYVIMRC="$HOME/.config/nvim/init.vim"
export GOPATH=~/go/bin

# Consolidate PATH exports
export PATH="$PATH:~/bin:$HOME/.dotnet/tools:$HOME/.local/bin:$GOPATH:$HOME/TEE-CLC"


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export GOOGLE_APPLICATION_CREDENTIALS=/Users/alainnormandin/Documents/dev.nosync/google/credentials/ma-carte-de-membre-a572c35fa253.json

#set -o vi





# Function pour décoder des token jw
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}



# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# alias tts="~/.claude/scripts/tts.sh"

# Claude Code LSP support
# export ENABLE_LSP_TOOL=1



