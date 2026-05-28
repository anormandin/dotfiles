# .zshenv - sourced for ALL zsh shells (interactive and non-interactive)
#

# Configure the zsh config 
if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
  export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi

# For non-interactive shells, load nvm and conda immediately
# (interactive shells use lazy loading from .zshrc)
if [[ ! -o interactive ]]; then
    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

    # Load conda
    if [ -f "/Users/alainnormandin/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/alainnormandin/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/alainnormandin/opt/anaconda3/bin:$PATH"
    fi
fi

# Load the XDG-located env file (set above). Guarded so an empty ZDOTDIR
# or missing file can't turn this into `source /.zshenv`.
if [[ -n "$ZDOTDIR" && -f "$ZDOTDIR/.zshenv" ]]; then
  source "$ZDOTDIR/.zshenv"
fi
