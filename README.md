# .dotfiles

## Usage

Clone this repo into your home directory. Then, while inside the directory run `mac install` to install the dotfiles. You can also run `mac clean` to clean up the dotfiles.

## Productivity Tool Suggestions

**1. zoxide** - Smarter `cd` that learns your habits
```bash
brew install zoxide
# Add to .zshrc: eval "$(zoxide init zsh)"
# Usage: z projects, z dot
```

**2. delta** - Better git diffs with syntax highlighting
```bash
brew install git-delta
# Add to .gitconfig:
[core]
    pager = delta
[delta]
    navigate = true
    line-numbers = true
```

**3. eza** - Modern `ls` replacement with git integration
```bash
brew install eza
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --icons"
```

**4. bat** - Already used in `o` alias, add more integrations
```bash
alias cat="bat --paging=never"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
```

**5. Useful git aliases** to add to `.gitconfig`:
```ini
[alias]
    st = status -sb
    co = checkout
    cob = checkout -b
    lg = log --oneline --graph --decorate -20
    undo = reset HEAD~1 --mixed
    stash-all = stash save --include-untracked
    wip = !git add -A && git commit -m 'WIP'
```

**6. fzf-tab** - Replace zsh's completion with fzf
```bash
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
# Add to plugins: plugins=(... fzf-tab)
```

**7. zsh-autosuggestions** - The `bindkey '^ ' autosuggest-accept` exists but the plugin isn't listed. Add it:
```bash
plugins=(git vi-mode gradle poetry zsh-autosuggestions)
```

### Organizational Improvements

- **Consolidate PATH exports** into a single file or group them together
- **Add `tms` script** to bin - referenced in `bindkey -s ^f "tms\n"` but not in the repo
- **Consider starship prompt** - faster and more customizable than bira theme
