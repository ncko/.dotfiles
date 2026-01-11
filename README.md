# .dotfiles

## New Machine Setup

```bash
git clone https://github.com/ncko/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap/install   # Install Homebrew packages + compile neovim
./mac install         # Create symlinks for dotfiles
```

## Usage

```bash
./mac install         # Install dotfiles (creates symlinks)
./mac clean           # Remove all symlinks
./mac reinstall       # Clean then install
./bootstrap/update    # Update all Homebrew packages and tools
```

## Tools

Managed via `bootstrap/Brewfile`:

**CLI:** bat, delta, eza, fd, fzf, gawk, gh, git, gsed, hurl, jq, mise, ripgrep, starship, stow, tmux, watch, zoxide

**Casks:** claude-code, docker, font-jetbrains-mono-nerd-font, ghostty, github, ngrok

**Manual:** neovim (compiled from source via `bootstrap/tools/neovim`)

