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
    # Load nvm (Homebrew path on macOS, standard ~/.nvm on Linux)
    export NVM_DIR="$HOME/.nvm"
    if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
        \. "/opt/homebrew/opt/nvm/nvm.sh"
    elif [ -s "$NVM_DIR/nvm.sh" ]; then
        \. "$NVM_DIR/nvm.sh"
    fi

    # Load conda (macOS install under ~/opt/anaconda3; skipped if absent)
    if [ -d "$HOME/opt/anaconda3" ]; then
        if [ -f "$HOME/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/opt/anaconda3/bin:$PATH"
        fi
    fi
fi

# Load the XDG-located env file (set above). Guarded so an empty ZDOTDIR
# or missing file can't turn this into `source /.zshenv`.
if [[ -n "$ZDOTDIR" && -f "$ZDOTDIR/.zshenv" ]]; then
  source "$ZDOTDIR/.zshenv"
fi

# uv installer env (adds ~/.local/bin to PATH); guarded for machines without uv
if [ -f "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi
