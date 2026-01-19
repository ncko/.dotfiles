# AGENTS.md

This file provides coding guidelines for AI agents (Cursor, Copilot, Claude Code, etc.) working in this dotfiles repository.

## Repository Overview

Personal dotfiles repository using **GNU Stow** for symlink management. Each top-level directory is a "stow package" that mirrors the home directory structure. See `CLAUDE.md` for architecture details.

## Build/Test/Lint Commands

### Installation & Testing
```bash
# Install dotfiles (creates symlinks)
./mac install

# Install specific packages only
STOW_FOLDERS=git,vim,zsh ./mac install

# Remove all symlinks
./mac clean

# Reinstall (clean + install)
./mac reinstall

# New machine setup (submodules, Homebrew, compile tools)
./bootstrap/install
./bootstrap/update
```

### Linting (Manual)
```bash
# No automated linting configured, but shellcheck is recommended for bash scripts:
shellcheck bin/.local/bin/*
shellcheck bootstrap/*

# Python scripts (no config file, but follow standard tools):
ruff check bin/.local/bin/  # Fast linter
mypy bin/.local/bin/         # Type checking
```

### Testing
```bash
# This repo has no custom tests
# Submodule tests (zsh-autosuggestions):
(cd omz-custom/plugins/zsh-autosuggestions && make test)  # Runs RSpec suite (subshell)
# Or: make -C omz-custom/plugins/zsh-autosuggestions test
```

### Validation
```bash
# Test that dotfiles can be installed without errors
./mac reinstall

# Verify shell configuration loads without errors
zsh -c 'source ~/.zshrc && echo "OK"'

# Check that custom scripts are executable
ls -la bin/.local/bin/
```

## Code Style Guidelines

### General Principles
- **Be conservative**: This is a personal dotfiles repo used daily. Test changes thoroughly.
- **Match existing style**: Consistency > perfection. Follow patterns already in the codebase.
- **No breaking changes**: Ensure backward compatibility with existing configurations.
- **Document complex logic**: Add comments for non-obvious behavior.

### Shell Scripts (Bash/Zsh)

#### File Structure
```bash
#!/usr/bin/env bash
# Use bash for scripts, zsh for interactive config files

# Optional: Enable strict mode for critical scripts
set -euo pipefail  # Use in bootstrap/install, bootstrap/update, devsync, etc.

# Functions before main logic
function help() {
    # Help text with examples
}

function main_action() {
    # Implementation
}

# Argument parsing with getopts
while getopts "abc:" option; do
    case "${option}" in
        a) action_a ;;
        *) help && exit 1 ;;
    esac
done
```

#### Style Rules
- **Indentation**: 2 spaces (most common) or 4 spaces (some files). Match surrounding code.
- **Naming**:
  - Scripts: lowercase with hyphens (`my-script`)
  - Functions: lowercase with underscores (`my_function`)
  - Variables: lowercase with underscores (`my_var`)
  - Environment vars: UPPERCASE (`DEVSYNC_HOST`)
- **Quoting**: Always quote variable expansions: `"$var"`, `"${array[@]}"`
- **Paths**: Use `realpath` for absolute paths: `realpath ~/deck`
- **Shebangs**: `#!/usr/bin/env bash` or `#!/usr/bin/env python3`
- **Exit codes**: Explicit `exit 0` on success, `exit 1` on error

#### Common Patterns
```bash
# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
echo -e "${GREEN}Success${NC}"

# Bold text
bold=$(tput bold)
normal=$(tput sgr0)
echo "${bold}HEADER${normal}"

# Interactive selection with fzf
result=$(find ~/projects -type d | fzf --reverse)

# Config file search up directory tree
search_dir="$PWD"
while [[ "$search_dir" != "/" ]]; do
    [[ -f "$search_dir/.config" ]] && config_file="$search_dir/.config" && break
    search_dir="$(dirname "$search_dir")"
done

# Help function pattern
function help() {
    cat <<EOF
Usage: script [options]

Options:
    -a    Do something
    -h    Show help

Examples:
    $ script -a value
EOF
}
```

### Python Scripts

#### Style
- **PEP 8 compliant** (mostly)
- **Indentation**: 4 spaces
- **Imports**: Standard library, then third-party, then local (separated by blank lines)
- **Type hints**: Not currently used, but acceptable to add
- **String formatting**: f-strings preferred: `f"{name} {ip}"`
- **Error handling**: Use try/except where appropriate

```python
#!/usr/bin/env python3

import os
from pprint import pprint

import boto3  # Third-party

# Simple scripts, no classes needed
ec2 = boto3.client("ec2")
result = ec2.describe_instances()
```

### Configuration Files

#### Zsh Configuration
```zsh
# omz-custom/*.zsh files

# Section headers
# === Database Functions ===

# Aliases: one per line
alias vim="nvim"
alias cat="bat --paging=never"

# Functions: descriptive names, handle errors
function aws-profile() {
    if [[ $# -gt 0 ]]; then
        export AWS_PROFILE=$1
    else
        unset AWS_PROFILE
    fi
}

# No theme (using Starship)
ZSH_THEME=""

# Tool initialization
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
```

#### Git Configuration
```gitconfig
# Use includes for user-specific config
[include]
    path = ~/.gitconfig_user  # Not tracked

# URL shortcuts
[url "git@github.com:"]
    insteadOf = gh:

# Delta for diffs
[core]
    pager = delta
```

### Error Handling

```bash
# Validate required config
if [[ -z "${REQUIRED_VAR:-}" ]]; then
    echo -e "${RED}Error: REQUIRED_VAR not set${NC}"
    exit 1
fi

# Check command exists
if ! command -v fswatch &> /dev/null; then
    echo -e "${RED}Error: fswatch not found${NC}"
    exit 1
fi

# Confirmation prompts
read -p "Overwrite? [y/N] " -n 1 -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
```

## Naming Conventions

### Files
- **Scripts**: lowercase-with-hyphens (e.g., `list-boxes`, `clickup-to-todoist`)
- **Config files**: Match tool conventions (`.zshrc`, `.gitconfig`, `.tmux.conf`)
- **Directories**: lowercase (e.g., `bootstrap/`, `omz-custom/`)

### Functions/Aliases
- **Aliases**: short, memorable (`ll`, `lt`, `vimbin`, `vimdot`)
- **Functions**: descriptive, verb-object (`aws-profile`, `open-session`)

## Important Patterns

### Tmux Integration
Many scripts open tmux sessions:
```bash
# Check if in tmux, create or attach session
open-session "/path/to/project"
```

### fzf Usage
Interactive selection is common:
```bash
# Use fzf-tmux in tmux contexts
session=$(find ~/projects -type d | fzf-tmux -p --reverse)

# Preview with bat
file=$(fd . | fzf --preview 'bat --color=always {}')
```

### Tool Replacements
Modern CLI tool replacements are standard:
- `nvim` instead of `vim`
- `bat` instead of `cat`
- `eza` instead of `ls`
- `fd` instead of `find`
- `rg` instead of `grep`
- GNU versions: `gsed`, `gawk`

## What NOT to Do

- ❌ Don't add test frameworks or CI/CD - this is a personal dotfiles repo
- ❌ Don't add shellcheck/linter config files unless explicitly requested
- ❌ Don't modify submodules (fzf-tab, zsh-autosuggestions) - they're external
- ❌ Don't change the stow package structure without careful consideration
- ❌ Don't commit sensitive data (SSH keys, API tokens, passwords)
- ❌ Don't use `cd` in scripts - it changes global state and is error-prone. Use absolute paths, subshells `(cd dir && cmd)`, or `-C` flags instead.
- ❌ Don't break existing scripts - they're used in daily workflows

## Testing Changes

Before committing:
1. Test installation: `./mac reinstall`
2. Source shell config: `source ~/.zshrc` (check for errors)
3. Test modified scripts manually
4. Verify symlinks: `ls -la ~/ | grep "\->"`
5. Check that nothing broke: run a few key scripts (`proj`, `vim`, etc.)

## Commit Messages

Follow existing patterns:
- Use lowercase, imperative mood: "add feature", "fix bug", "update config"
- Be concise but descriptive
- Examples:
  - `add devsync watch mode`
  - `fix proj tmux session handling`
  - `update brewfile with new tools`

## Additional Context

- **Private content**: `crossfit/` is a git submodule (private repo)
- **Machine-specific**: `omz-custom/machine.zsh` is not tracked (`.gitignore`d)
- **1Password SSH**: SSH keys served by 1password agent, not stored on disk
- **Stow packages**: Default is `git,vim,zsh,bin,tmux,crossfit,keep,ghostty,aws,ssh`
