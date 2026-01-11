# .dotfiles

## Usage

Clone this repo into your home directory. Then, while inside the directory run `mac install` to install the dotfiles. You can also run `mac clean` to clean up the dotfiles.

## Optional Tools

These tools are configured but need to be installed:

```bash
brew install zoxide delta eza
```

- **zoxide** - Smarter `cd` that learns your habits (`z projects`, `z dot`)
- **delta** - Better git diffs with syntax highlighting
- **eza** - Modern `ls` replacement with icons and git integration

## Future Improvements

- **Add `tms` script** to bin - referenced in `bindkey -s ^f "tms\n"` but not in the repo
- **Consider starship prompt** - faster and more customizable than bira theme
