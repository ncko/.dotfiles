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

- **ghostty** - GPU-accelerated terminal emulator
- **zoxide** - Smarter `cd` that learns your habits (`z projects`, `z dot`)
- **delta** - Better git diffs with syntax highlighting
- **eza** - Modern `ls` replacement with icons and git integration
- **starship** - Fast, customizable prompt
- **neovim** - Compiled from source via `bootstrap/tools/neovim`

## Future Improvements

- **Add `tms` script** to bin - referenced in `bindkey -s ^f "tms\n"` but not in the repo
