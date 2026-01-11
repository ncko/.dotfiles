# .dotfiles

## Usage

Clone this repo into your home directory. Then, while inside the directory run `mac install` to install the dotfiles. You can also run `mac clean` to clean up the dotfiles.

## Required Tools

```bash
brew install --cask ghostty font-jetbrains-mono-nerd-font
brew install zoxide delta eza starship
```

- **ghostty** - GPU-accelerated terminal emulator
- **font-jetbrains-mono-nerd-font** - Nerd Font for terminal icons
- **zoxide** - Smarter `cd` that learns your habits (`z projects`, `z dot`)
- **delta** - Better git diffs with syntax highlighting
- **eza** - Modern `ls` replacement with icons and git integration
- **starship** - Fast, customizable prompt

## Future Improvements

- **Add `tms` script** to bin - referenced in `bindkey -s ^f "tms\n"` but not in the repo
