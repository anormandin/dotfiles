# dotfiles

My personal configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Everything lives under a single Stow package named **`home/`**. Stow mirrors that
tree into `$HOME` as symlinks, so editing a file in this repo edits the live config.

## What's tracked

```
home/
├── .zshenv               # sets ZDOTDIR=~/.config/zsh, lazy-loads nvm/conda
├── .zprofile             # login-shell setup
└── .config/
    ├── alacritty/        # terminal
    ├── ccstatusline/     # Claude Code status line
    ├── emacs/            # only init.el is tracked (elpa/ etc. are gitignored)
    ├── git/              # global git config (ignore = excludesfile)
    ├── nvim/             # Neovim (init.lua + lua/config/* layout)
    ├── starship.toml     # shell prompt (used by zsh via prompt.zsh)
    ├── tmux/
    ├── wezterm/
    └── zsh/              # interactive shell: .zshrc, aliases.zsh, prompt.zsh, plugins.zsh
```

> zsh is **XDG-based**: `~/.zshenv` points `ZDOTDIR` at `~/.config/zsh`, so the real
> interactive config is `~/.config/zsh/.zshrc` — **not** `~/.zshrc`.

## Setting up a new computer

### 1. Install prerequisites

```bash
# macOS (Homebrew)
brew install stow git zsh starship neovim tmux eza ripgrep
```

| Tool        | Why |
|-------------|-----|
| `stow`      | creates the symlinks |
| `starship`  | the shell prompt (reads `starship.toml`) |
| `eza`       | `ls`/`ll`/`la`/`tree` aliases |
| `ripgrep`   | `grep` alias (`rg`) |
| `neovim`    | editor (`$EDITOR`) |
| `tmux`      | terminal multiplexer |

(Terminal emulators — Alacritty / WezTerm — only needed if you use them.)

### 2. Clone the repo

```bash
git clone git@github.com:anormandin/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

> The repo **must** live at `~/dotfiles` for the symlink paths to resolve.

### 3. Stow it

```bash
cd ~/dotfiles
stow -n -v -t ~ home   # dry run — preview, changes nothing
stow -v -t ~ home      # for real
```

If Stow reports a **conflict**, the target already has a real file (e.g. a default
`~/.zshenv`). Back it up and remove it, then re-run:

```bash
mv ~/.zshenv ~/.zshenv.bak
stow -v -t ~ home
```

### 4. Start a new shell

```bash
exec zsh
```

On first launch `plugins.zsh` auto-clones the zsh plugins into
`~/.config/zsh/plugins/` (gitignored — reproducible, never committed).

## Day-to-day (aliases in `home/.config/zsh/aliases.zsh`)

```bash
dot        # cd ~/dotfiles
stow-on    # stow -v -t ~ -d ~/dotfiles home      (create/refresh links)
stow-off   # stow -D -v -t ~ -d ~/dotfiles home   (remove links)
restow     # stow -R -v -t ~ -d ~/dotfiles home   (re-stow; picks up new files)
stow-dry   # stow -n -v -t ~ -d ~/dotfiles home   (preview only)
```

**Adding a new config:** move the file into `home/.config/…`, then run `restow`.

## Notes / gotchas

- **Don't use a flat layout** (configs at the repo root). Stow 2.4 self-skips it
  because stow-dir == target == `$HOME`, creating zero links. Always keep the
  `home/` package subdirectory.
- Generated/reproducible files are **gitignored**: zsh `plugins/`, `.zcompdump*`,
  `.zsh_history`, emacs `elpa/` + backups, nvim `.claude/settings.local.json`.
- After moving files in/out of the package, run `restow` so Stow re-folds the tree.