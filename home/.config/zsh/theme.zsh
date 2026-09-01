# Theme system (managed by the `theme` CLI — see ~/dotfiles/themes/)
# fzf colors for the current theme (appends to FZF_DEFAULT_OPTS set in fzf.zsh)
[ -f "$HOME/.config/theme-current/fzf.zsh" ] && source "$HOME/.config/theme-current/fzf.zsh"

# lazygit: layer the themed config on top of the main one
if [ -f "$HOME/.config/theme-current/lazygit.yml" ]; then
  export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/theme-current/lazygit.yml"
fi
