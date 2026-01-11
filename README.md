# .dotfiles

## Quick Start

### New Machine Setup

```bash
git clone https://github.com/ncko/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap/install   # Install Homebrew packages + compile neovim
./mac install         # Create symlinks for dotfiles
```

### Daily Usage

```bash
./mac install         # Install dotfiles (creates symlinks)
./mac clean           # Remove all symlinks
./mac reinstall       # Clean then install
./bootstrap/update    # Update all Homebrew packages and tools
```

### Selective Installation

```bash
STOW_FOLDERS=git,vim,zsh ./mac install  # Install specific packages only
```

**Default packages:** `git,vim,zsh,bin,tmux,crossfit,keep,ghostty,aws`

---

## Stow Packages

Each directory is a stow package. Contents are symlinked relative to `$HOME`.

| Package | Description | Key Files |
|---------|-------------|-----------|
| `git` | Git configuration | `.gitconfig` - aliases, delta pager, rebase defaults |
| `vim` | Editor config | `.vimrc`, `.ideavimrc` (JetBrains) |
| `zsh` | Shell configuration | `.zshrc`, `.zprofile` |
| `bin` | Custom scripts | `.local/bin/*` - 15 utility scripts |
| `tmux` | Terminal multiplexer | `.tmux.conf` - Tokyo Night theme |
| `ghostty` | Terminal emulator | `.config/ghostty/config` |
| `aws` | AWS tools | `.sawsrc` for SAWS shell |
| `keep` | Misc data files | Alarm sounds, homelab nodes, snippet database |
| `omz-custom` | Oh My Zsh custom | Aliases, environment, plugins (sourced, not stowed) |

---

## CLI Scripts

Located in `bin/.local/bin/`, available after installation.

### Project & Session Management

#### `proj` - Project Manager
Navigate and create projects with tmux sessions.

```bash
proj                      # Interactive selection from ~/deck and ~/projects
proj -d myproject         # Create new project in ~/deck/myproject
proj -n owner/repo        # Create in ~/projects/owner/repo
proj -c owner/repo        # Clone GitHub repo to ~/projects/owner/repo
```

#### `open-session` - Tmux Session Opener
Create or attach to tmux sessions by directory path.

```bash
open-session ~/projects/myapp
```

### Remote & SSH

#### `box` - EC2 Instance Manager
SSH into AWS EC2 instances with fzf selection.

```bash
box                       # Interactive SSH (uses cached instances)
box generate              # Refresh EC2 instance cache
box -u admin              # SSH with specific username
box tunnel                # Open reverse tunnel (port 9001)
```

#### `devsync` - Remote Development Sync
Sync local directories to remote devbox via rsync.

```bash
devsync --init            # Create .devsync config in current directory
devsync                   # Sync current directory to remote
devsync --watch           # Watch for changes and auto-sync
devsync --dry-run         # Preview without syncing
```

**Configuration** (`.devsync` file):
```bash
DEVSYNC_HOST=user@devbox.example.com
DEVSYNC_REMOTE_PATH=/home/user/projects/myproject
DEVSYNC_EXCLUDE=(.git node_modules vendor)
```

#### `homebox` - Homelab SSH
SSH into homelab nodes with fzf selection.

```bash
homebox
```

### Knowledge & Notes

#### `shit` - Snippet Manager
Personal knowledge base / cheat sheet manager.

```bash
shit                      # Browse and display snippets
shit add -c bash -i "print hello"  # Add snippet (opens editor)
shit edit                 # Edit existing snippet
shit delete               # Delete snippet
shit dump                 # Export all as JSON
```

#### `move-note` - Obsidian Note Mover
Move notes between Obsidian vaults with attachment handling.

```bash
move-note personal        # Move selected note to personal vault
move-note work            # Move selected note to work vault
```

### Utilities

#### `timer` - Countdown Timer
Terminal countdown with audio alert.

```bash
timer 5m                  # 5 minute timer
timer 1h30m               # 1 hour 30 minutes
timer 30s                 # 30 seconds
```

#### `youtube` - YouTube Clip Downloader
Download specific segments from YouTube videos.

```bash
youtube -s 11:32 -d 1:10 -u "https://youtube.com/watch?v=..."
```

#### `myip` - Public IP
Display your public IP address.

```bash
myip
```

#### `rosetta` - x86_64 Shell
Launch x86_64 shell on ARM Mac for compatibility.

```bash
rosetta
```

#### `graveyard` - Script Archive
Browse archived/deprecated scripts.

```bash
graveyard
```

#### `sort-revisions` - Alembic Helper
Print Alembic migrations in dependency order.

```bash
sort-revisions
```

#### `clickup-to-todoist` - Task Sync
Sync ClickUp "breakdown" tasks to Todoist.

```bash
clickup-to-todoist
```

Requires: `CLICKUP_API_KEY`, `TODOIST_API_KEY` environment variables.

---

## Shell Aliases & Functions

### CLI Tool Replacements

| Alias | Expands To | Description |
|-------|------------|-------------|
| `vim` | `nvim` | Neovim |
| `cat` | `bat --paging=never` | Syntax highlighted output |
| `ls` | `eza --icons` | Modern ls with icons |
| `ll` | `eza -la --icons --git` | Long format with git status |
| `lt` | `eza --tree --icons` | Tree view |
| `sed` | `gsed` | GNU sed |
| `awk` | `gawk` | GNU awk |

### Quick Edit

| Alias | Opens |
|-------|-------|
| `vimconfig` | Neovim config (`~/.dotfiles/nvim/.config/nvim/lua/ncko`) |
| `vimbin` | Custom scripts (`~/.dotfiles/bin/.local/bin`) |
| `vimdot` | Dotfiles root (`~/.dotfiles`) |
| `o` | File picker with fzf + bat preview |

### Development

| Alias | Description |
|-------|-------------|
| `be` | `bundle exec` |
| `poe` | `poetry poe` (task runner) |
| `amend` | `git add . && git commit --amend --no-edit` |
| `php8.0` | Run PHP 8.0 in Docker |

### Tmux Splits

| Alias | Description |
|-------|-------------|
| `vsp` | Vertical split (narrow) |
| `vspw` | Vertical split (wide monitor) |
| `vsd` | Horizontal split (down) |

### Command Saving

```bash
slc                       # Save last command to cache
slg <pattern>             # Search saved commands
```

### AWS

#### `aws-profile` - Profile Switcher
```bash
aws-profile production    # Set AWS_PROFILE
aws-profile               # Unset AWS_PROFILE
```

### MySQL

#### `mydb` - Connection Manager
Manage and connect to saved MySQL connections.

```bash
mydb                      # Interactive connection selection
mydb --add                # Add new connection
mydb --list               # List saved connections
mydb --remove             # Remove a connection
mydb myconnection         # Connect to named connection
```

Connections stored in `~/.local/share/mydb/connections`.

#### Quick Queries
```bash
myq "SELECT * FROM users"        # Run query
myqv "SELECT * FROM users"       # Vertical output (wide tables)
```

### DynamoDB

```bash
ddb-tables                # List all tables
ddb-describe [table]      # Describe table (fzf if no arg)
ddb-scan [table] [limit]  # Scan table (default 25 items)
ddb-count [table]         # Get item count
ddb-query <table> <key> <value>  # Query by partition key
```

### Mermaid Diagrams

```bash
mmd diagram.mmd           # Render to PNG (dark theme)
mmd-svg diagram.mmd       # Render to SVG
mmd-pdf diagram.mmd       # Render to PDF
mmd-watch diagram.mmd     # Auto-render on file changes
```

### Jupyter

```bash
jlab                      # Start Jupyter Lab
jlab-nb                   # Start without browser
jnb                       # Classic notebook
jlist                     # List running servers
jstop                     # Stop all servers
nbconvert nb.ipynb html   # Convert (html/pdf/markdown/script/slides)
nbexec nb.ipynb           # Execute and save output
nbnew mynotebook          # Create new notebook
```

### Utilities

```bash
tldrf                     # Fuzzy search tldr pages
```

---

## Keybindings

### Shell (Zsh)

| Binding | Action |
|---------|--------|
| `Ctrl+F` | Open tmux session menu |
| `Ctrl+Space` | Accept autosuggestion |

### Tmux

| Binding | Action |
|---------|--------|
| `Ctrl+Space` | Prefix (not Ctrl+B) |
| `Prefix + \` | Split horizontally |
| `Prefix + -` | Split vertically |
| `Prefix + h/j/k/l` | Navigate panes (vim-style) |
| `Prefix + r` | Reload config |
| `Prefix + p` | Open proj manager |
| `Prefix + b` | Open cfbox |

---

## Git Configuration

### Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `git st` | `status -sb` | Short status with branch |
| `git co` | `checkout` | Switch branches |
| `git cob` | `checkout -b` | Create and switch branch |
| `git lg` | `log --graph...` | Visual log (20 commits) |
| `git undo` | `reset HEAD~1 --mixed` | Undo last commit, keep changes |
| `git stash-all` | `stash --include-untracked` | Stash everything |
| `git wip` | `add -A && commit -m 'WIP'` | Quick WIP commit |

### URL Shorthands

```bash
git clone gh:owner/repo   # Clones git@github.com:owner/repo
```

### Settings

- **Pager:** Delta (syntax highlighted diffs)
- **Pull:** Rebase by default
- **Editor:** Neovim
- **User config:** Loaded from `.gitconfig_user` (not tracked)

---

## Tmux Configuration

- **Theme:** Tokyo Night
- **Base index:** 1 (windows/panes start at 1)
- **Copy mode:** Vi keybindings
- **Status bar:** Session name (left), time + host (right)

---

## Installed Tools

Managed via `bootstrap/Brewfile`.

### CLI Tools

| Tool | Description |
|------|-------------|
| `bat` | Cat with syntax highlighting |
| `delta` | Better git diffs |
| `eza` | Modern ls replacement |
| `fd` | Find alternative |
| `fzf` | Fuzzy finder |
| `gh` | GitHub CLI |
| `hurl` | HTTP client |
| `jq` | JSON processor |
| `mise` | Runtime version manager |
| `ripgrep` | Fast grep (`rg`) |
| `starship` | Shell prompt |
| `stow` | Symlink manager |
| `tmux` | Terminal multiplexer |
| `zoxide` | Smart cd (`z`) |

### Database & Cloud

| Tool | Description |
|------|-------------|
| `mysql-client` | MySQL CLI (mysql, mysqldump) |
| `awscli` | AWS CLI |

### Development

| Tool | Description |
|------|-------------|
| `jupyterlab` | Jupyter notebooks |
| `mermaid-cli` | Diagram renderer (`mmdc`) |
| `python-lsp-server` | Python LSP |

### File Operations

| Tool | Description |
|------|-------------|
| `rsync` | File sync |
| `fswatch` | File watcher |

### GUI Applications (Casks)

| App | Description |
|-----|-------------|
| `claude-code` | Claude Code IDE |
| `docker` | Container platform |
| `ghostty` | Terminal emulator |
| `github` | GitHub Desktop |
| `ngrok` | Tunneling |

### Manual Installations

| Tool | Description |
|------|-------------|
| `neovim` | Compiled from source via `bootstrap/tools/neovim` |

---

## Machine-Specific Config

Create `omz-custom/machine.zsh` for machine-specific settings (not tracked):

```bash
# Example machine.zsh
export CUSTOM_VAR="value"
alias myalias="custom command"
```

---

## Private Configuration

The `crossfit/` directory is a git submodule pointing to a private repository.

To set up on a new machine with access:

```bash
git submodule update --init --recursive
```
