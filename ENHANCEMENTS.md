# Dotfiles Enhancements Plan

Tracking implementation of shell enhancements. Tackle one at a time.

## Status

- [x] Secret Management with 1password SSH Agent
- [ ] Directory Bookmarks with Zoxide
- [ ] Command Timing
- [ ] Notification on Completion
- [ ] Per-Project Tool Versions with mise
- [ ] LLM Shell Integration
- [ ] Terminal Recording with asciinema
- [ ] Searchable Alias Index

---

## 1. Secret Management with 1password SSH Agent

Uses 1password's native SSH agent to serve SSH keys without storing them on disk.

### What Was Implemented

**Brewfile additions:**
- `cask "1password"` - Desktop app with SSH agent
- `brew "1password-cli"` - CLI for secrets automation

**SSH config (`ssh/.ssh/config`):**
```
Host *
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
```

### Bootstrap Flow (New Machine)

```bash
# 1. Clone public dotfiles via HTTPS
git clone https://github.com/ncko/dotfiles.git ~/.dotfiles

# 2. Install homebrew (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Install 1password first
brew install --cask 1password
brew install 1password-cli

# 4. Sign into 1password app and enable SSH agent:
#    Settings > Developer > SSH Agent (toggle on)
#    Settings > Developer > "Use the SSH agent" (toggle on)

# 5. Add your SSH key to 1password (if not already there):
#    - Create new item > SSH Key
#    - Either generate new or import existing private key

# 6. Run full bootstrap
./bootstrap/install
./mac install

# 7. Verify SSH works
ssh -T git@github.com

# 8. Now clone private submodules
git submodule update --init
```

### Manual Steps Required

After running bootstrap, you must manually:

1. **Open 1password app** and sign in
2. **Enable SSH Agent**: Settings > Developer > SSH Agent
3. **Add SSH keys** to your 1password vault (or they may sync from another device)
4. **Authorize the key** for GitHub at github.com/settings/keys

### Optional: CLI Secrets (for API keys, etc.)

For non-SSH secrets like API keys, add to `omz-custom/secrets.zsh`:

```zsh
function load_secrets() {
  if ! op account list &>/dev/null; then
    eval $(op signin)
  fi
  export OPENAI_API_KEY=$(op read "op://Private/OpenAI/api_key")
  export GITHUB_TOKEN=$(op read "op://Private/GitHub Token/credential")
}
```

---

## 2. Directory Bookmarks with Zoxide

**Setup:**
```bash
brew install zoxide
```

**Implementation (`omz-custom/zoxide.zsh`):**
```zsh
eval "$(zoxide init zsh)"

# Replace cd entirely (optional but recommended)
alias cd="z"

# Interactive selection with fzf
alias zi="z -i"

# Add current directory with a custom keyword
function zmark() {
  # Adds current dir multiple times to boost its score
  for i in {1..10}; do zoxide add "$(pwd)"; done
  echo "Boosted: $(pwd)"
}

# List all entries sorted by score
alias zlist="zoxide query -l -s"

# Remove current directory from database
alias zrm="zoxide remove \$(pwd)"

# Jump to project and open in editor
function zv() {
  z "$@" && nvim .
}

# Combine with your existing proj script
function zproj() {
  local dir=$(zoxide query -l | fzf --preview 'eza -la --color=always {}')
  [[ -n "$dir" ]] && cd "$dir" && tmux rename-window "$(basename $dir)"
}
```

---

## 3. Command Timing

**Implementation (`omz-custom/timing.zsh`):**
```zsh
# Track command start time
function preexec() {
  _cmd_start=$EPOCHREALTIME
  _last_cmd=$1
}

# Display duration after command completes
function precmd() {
  if [[ -n "$_cmd_start" ]]; then
    local elapsed=$(( EPOCHREALTIME - _cmd_start ))

    # Only show for commands taking > 3 seconds
    if (( elapsed > 3 )); then
      local mins=$(( elapsed / 60 ))
      local secs=$(( elapsed % 60 ))

      if (( mins > 0 )); then
        printf '\n⏱  %dm %.1fs\n' $mins $secs
      else
        printf '\n⏱  %.1fs\n' $secs
      fi
    fi

    unset _cmd_start
  fi
}

# Alternative: Use zsh's built-in REPORTTIME
# Automatically reports time for commands taking > N seconds
REPORTTIME=3
TIMEFMT=$'\n⏱  %E total, %U user, %S system, %P cpu'
```

---

## 4. Notification on Completion

**Optional setup:**
```bash
brew install terminal-notifier
```

**Implementation (`omz-custom/notify.zsh`):**
```zsh
# Threshold in seconds
NOTIFY_THRESHOLD=30

function preexec() {
  _cmd_start=$EPOCHSECONDS
  _last_cmd=$1
}

function precmd() {
  local exit_code=$?

  if [[ -n "$_cmd_start" ]]; then
    local elapsed=$(( EPOCHSECONDS - _cmd_start ))

    if (( elapsed >= NOTIFY_THRESHOLD )); then
      local status="✅ Completed"
      local sound="Glass"
      [[ $exit_code -ne 0 ]] && status="❌ Failed ($exit_code)" && sound="Basso"

      # macOS notification
      osascript -e "display notification \"${_last_cmd:0:50}\" with title \"$status\" subtitle \"Took ${elapsed}s\" sound name \"$sound\""

      # Alternative: terminal-notifier (more features)
      # terminal-notifier -title "$status" -message "${_last_cmd:0:50}" -subtitle "Took ${elapsed}s"
    fi

    unset _cmd_start _last_cmd
  fi
}

# Manual trigger: prefix any command with 'alert'
function alert() {
  "$@"
  local exit_code=$?
  osascript -e "display notification \"$*\" with title \"Command finished\" sound name \"Glass\""
  return $exit_code
}

# Usage: alert make build
```

---

## 5. Per-Project Tool Versions with mise

**Setup:**
```bash
brew install mise
```

**Implementation (`omz-custom/mise.zsh`):**
```zsh
eval "$(mise activate zsh)"

# Auto-create .mise.toml for current project
function mise-init() {
  cat > .mise.toml << 'EOF'
[tools]
node = "lts"
python = "3.12"

[env]
_.path = ["./node_modules/.bin", "./venv/bin"]
EOF
  echo "Created .mise.toml"
}

# Quick version switches
alias node18="mise use node@18"
alias node20="mise use node@20"
alias py311="mise use python@3.11"
alias py312="mise use python@3.12"
```

**Example `.mise.toml` in a project:**
```toml
[tools]
node = "20.10.0"
python = "3.12.1"
terraform = "1.6.0"
awscli = "2.15.0"

[env]
DATABASE_URL = "postgres://localhost/myapp_dev"
_.path = ["./bin", "./node_modules/.bin"]

[tasks]
build = "npm run build"
test = "pytest"
```

---

## 6. LLM Shell Integration

**Implementation (`omz-custom/llm.zsh`):**
```zsh
# Quick command generation (requires OPENAI_API_KEY)
function ai() {
  local prompt="$*"
  local result=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "model": "gpt-4o-mini",
      "messages": [
        {"role": "system", "content": "You are a command-line expert. Output ONLY the command, no explanation. Use standard Unix tools available on macOS."},
        {"role": "user", "content": "'"$prompt"'"}
      ]
    }' | jq -r '.choices[0].message.content')

  echo "$ $result"
  echo -n "Run? [y/N] "
  read -r confirm
  [[ "$confirm" =~ ^[Yy]$ ]] && eval "$result"
}

# Explain last command
function explain() {
  local cmd="${1:-$(fc -ln -1)}"
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "model": "gpt-4o-mini",
      "messages": [
        {"role": "system", "content": "Explain this command concisely. Include what each flag does."},
        {"role": "user", "content": "'"$cmd"'"}
      ]
    }' | jq -r '.choices[0].message.content'
}

# Fix last failed command
function fix() {
  local last_cmd=$(fc -ln -1)
  local error=$(fc -ln -1 2>&1)
  ai "fix this command that failed: $last_cmd"
}

# Usage:
# ai "find all js files modified in last week larger than 1mb"
# explain "tar -xzvf archive.tar.gz"
# fix  # after a command fails
```

**Alternative tools:**
```bash
# GitHub Copilot CLI
brew install gh
gh extension install github/gh-copilot
# Then: ghcs "your prompt"

# Or: Shell-GPT
pip install shell-gpt
# Then: sgpt "your prompt"
```

---

## 7. Terminal Recording with asciinema

**Setup:**
```bash
brew install asciinema
brew install agg  # for GIF conversion

# Optional: link to asciinema account
asciinema auth
```

**Config file (`~/.config/asciinema/config`):**
```ini
[record]
stdin = yes
idle_time_limit = 2
```

**Implementation (`omz-custom/recording.zsh`):**
```zsh
# Quick recording with auto-generated filename
function rec() {
  local name="${1:-recording-$(date +%Y%m%d-%H%M%S)}"
  local file="$HOME/recordings/${name}.cast"
  mkdir -p "$HOME/recordings"

  echo "Recording to: $file"
  echo "Press Ctrl+D or type 'exit' to stop"
  asciinema rec "$file"

  echo "\nRecording saved. Options:"
  echo "  Play:   asciinema play $file"
  echo "  Upload: asciinema upload $file"
  echo "  GIF:    agg $file ${file%.cast}.gif"
}

# Play back a recording at custom speed
function replay() {
  asciinema play -s "${2:-1}" "$1"  # -s 2 = 2x speed
}

# List all recordings
alias recordings="eza -l ~/recordings/*.cast"

# Convert to GIF (requires agg)
function rec2gif() {
  agg "$1" "${1%.cast}.gif" --theme monokai
}
```

---

## 8. Searchable Alias Index

**Implementation (`omz-custom/help.zsh`):**
```zsh
# Search all aliases with descriptions
function aliases() {
  local query="$1"

  {
    # Parse aliases with inline comments
    alias | while IFS='=' read -r name value; do
      printf "%-20s %s\n" "${name#alias }" "$value"
    done

    # Also show functions (one-liners)
    typeset -f | grep -E '^\w+ \(\)' | sed 's/ ().*//'
  } | fzf --query="$query" \
      --preview='alias {1} 2>/dev/null || typeset -f {1}' \
      --preview-window=up:3:wrap
}

# Search through all zsh files for alias/function definitions with comments
function halp() {
  local query="$1"

  grep -h -E '^\s*(alias|function)\s+\w+' ~/.dotfiles/omz-custom/*.zsh 2>/dev/null | \
    sed 's/^[[:space:]]*//' | \
    fzf --query="$query" \
        --preview-window=hidden \
        --header="Aliases & Functions"
}

# Search with comments visible (requires documented aliases)
function cheat() {
  grep -h '#' ~/.dotfiles/omz-custom/*.zsh | \
    grep -E '^\s*(alias|function|export)' | \
    column -t -s '#' | \
    fzf --query="$1"
}

# Best approach: use ?? to search self-documenting aliases
# Format aliases like: alias gs="git status"  #git: short status
function ?? () {
  grep -h '#.*:' ~/.dotfiles/omz-custom/*.zsh | \
    grep -E '^\s*alias' | \
    sed 's/alias //' | \
    awk -F'#' '{printf "%-30s %s\n", $1, $2}' | \
    fzf --query="$*" --header="?? <query> - search aliases"
}
```

**Self-documenting alias format:**
```zsh
# Format: alias name="command"  #category: description
alias gs="git status"           #git: short status
alias gd="git diff"             #git: unstaged changes
alias vim="nvim"                #editor: neovim
alias ls="eza --icons"          #files: list with icons
```

---

## Brewfile Additions

Add to `bootstrap/Brewfile`:
```ruby
# Dotfiles enhancements
brew "1password-cli"
brew "zoxide"
brew "mise"
brew "asciinema"
brew "agg"
brew "terminal-notifier"
```
