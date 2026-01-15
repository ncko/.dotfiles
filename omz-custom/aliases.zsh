# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
alias cat="bat --paging=never"
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --icons"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias vimconfig="vim ~/.dotfiles/nvim/.config/nvim/lua/ncko"
alias vimbin="vim ~/.dotfiles/bin/.local/bin"
alias vimcfbin="vim ~/projects/ncko/crossfit/.local/bin"
alias vimdot="vim ~/.dotfiles"
alias o="nvim \$(fd --exclude .git -H . | fzf --reverse --preview 'bat --color=always {}')"
alias be="bundle exec"

# save last command
alias slc="fc -ln -1 | sed 's/^\*//' >> $HOME/.cache/ncko/saved_cmds"
# grep saved commands
alias slg="< $HOME/.cache/ncko/saved_cmds grep"

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% --layout reverse | xargs tldr'


# key bindings
bindkey -s ^f "tms\n"
bindkey '^ ' autosuggest-accept

alias php8.0="docker run -it php:8.0-cli"

alias poe="poetry poe"

alias vsp="tmux split-window -h && tmux resize-pane -L 25" # [v]ertical [sp]lit
alias vspw="tmux split-window -h && tmux resize-pane -L 85" # [v]ertical [sp]lit for [w]ide monitor
alias vsd="tmux split-window -v && tmux resize-pane -D 15"
alias tree="tree --dirsfirst"
alias amend="git add .;git commit --amend --no-edit"


aws-profile() {

    if [[ $# -gt 0 ]]; then
        export AWS_PROFILE=$1
    else
        unset AWS_PROFILE
    fi

    source ~/.zshrc
}


# =============================================================================
# MySQL Helpers
# =============================================================================

# Connection helper - stores connections in ~/.local/share/mydb/connections
# Usage: mydb <connection_name> or mydb --add <name> to add a new connection
mydb() {
    local data_dir="$HOME/.local/share/mydb"
    local connections_file="$data_dir/connections"

    mkdir -p "$data_dir"
    touch "$connections_file"

    case "${1:-}" in
        --add|-a)
            echo "Adding new MySQL connection..."
            read -p "Connection name: " conn_name
            read -p "Host: " conn_host
            read -p "Port [3306]: " conn_port
            conn_port="${conn_port:-3306}"
            read -p "Database: " conn_db
            read -p "User: " conn_user
            echo "$conn_name|$conn_host|$conn_port|$conn_db|$conn_user" >> "$connections_file"
            echo "Connection '$conn_name' saved. Password will be prompted on connect."
            ;;
        --list|-l)
            echo "Saved connections:"
            cut -d'|' -f1 "$connections_file" | nl
            ;;
        --remove|-r)
            local to_remove="${2:-$(cut -d'|' -f1 "$connections_file" | fzf --prompt="Remove connection: ")}"
            if [[ -n "$to_remove" ]]; then
                grep -v "^$to_remove|" "$connections_file" > "$connections_file.tmp"
                mv "$connections_file.tmp" "$connections_file"
                echo "Removed connection: $to_remove"
            fi
            ;;
        "")
            # Interactive selection with fzf
            local selected
            selected=$(cut -d'|' -f1 "$connections_file" | fzf --prompt="MySQL connection: ")
            [[ -z "$selected" ]] && return 0
            mydb "$selected"
            ;;
        *)
            # Connect using saved connection
            local conn_line
            conn_line=$(grep "^$1|" "$connections_file")
            if [[ -z "$conn_line" ]]; then
                echo "Connection '$1' not found. Use 'mydb --add' to create one."
                return 1
            fi
            local host port db user
            IFS='|' read -r _ host port db user <<< "$conn_line"
            echo "Connecting to $db@$host:$port as $user..."
            mysql -h "$host" -P "$port" -u "$user" -p "$db"
            ;;
    esac
}

# Quick MySQL query from command line
# Usage: myq "SELECT * FROM users LIMIT 10"
alias myq='mysql -e'

# MySQL with vertical output (easier to read wide tables)
alias myqv='mysql -E -e'


# =============================================================================
# DynamoDB Helpers
# =============================================================================

# List all DynamoDB tables
alias ddb-tables='aws dynamodb list-tables --output table'

# Describe a table (with fzf selection)
ddb-describe() {
    local table="${1:-$(aws dynamodb list-tables --query "TableNames[]" --output text | tr '\t' '\n' | fzf --prompt="Select table: ")}"
    [[ -z "$table" ]] && return 0
    aws dynamodb describe-table --table-name "$table" --output yaml
}

# Scan a table (returns first 25 items by default)
# Usage: ddb-scan <table_name> [limit]
ddb-scan() {
    local table="${1:-$(aws dynamodb list-tables --query "TableNames[]" --output text | tr '\t' '\n' | fzf --prompt="Select table: ")}"
    [[ -z "$table" ]] && return 0
    local limit="${2:-25}"
    aws dynamodb scan --table-name "$table" --limit "$limit" --output json | jq '.Items'
}

# Get item count for a table
ddb-count() {
    local table="${1:-$(aws dynamodb list-tables --query "TableNames[]" --output text | tr '\t' '\n' | fzf --prompt="Select table: ")}"
    [[ -z "$table" ]] && return 0
    aws dynamodb describe-table --table-name "$table" --query "Table.ItemCount" --output text
}

# Query a table by partition key
# Usage: ddb-query <table> <key_name> <key_value>
ddb-query() {
    local table="$1"
    local key_name="$2"
    local key_value="$3"

    if [[ -z "$table" || -z "$key_name" || -z "$key_value" ]]; then
        echo "Usage: ddb-query <table> <key_name> <key_value>"
        return 1
    fi

    aws dynamodb query \
        --table-name "$table" \
        --key-condition-expression "#k = :v" \
        --expression-attribute-names "{\"#k\": \"$key_name\"}" \
        --expression-attribute-values "{\":v\": {\"S\": \"$key_value\"}}" \
        --output json | jq '.Items'
}


# =============================================================================
# Mermaid Diagram Helpers
# =============================================================================

# Render mermaid diagram to PNG
# Usage: mmd diagram.mmd [output.png] [width]
mmd() {
    local input="$1"
    local output="${2:-${input%.*}.png}"
    local width="$3"

    if [[ -z "$input" ]]; then
        echo "Usage: mmd <input.mmd> [output.png] [width]"
        return 1
    fi

    mmdc -i "$input" -o "$output" ${width:+-w "$width"}
    echo "Created: $output"
}

# Render mermaid to SVG
mmd-svg() {
    local input="$1"
    local output="${2:-${input%.*}.svg}"
    local width="$3"

    if [[ -z "$input" ]]; then
        echo "Usage: mmd-svg <input.mmd> [output.svg] [width]"
        return 1
    fi

    mmdc -i "$input" -o "$output" ${width:+-w "$width"}
    echo "Created: $output"
}

# Render mermaid to PDF
mmd-pdf() {
    local input="$1"
    local output="${2:-${input%.*}.pdf}"
    local width="$3"

    if [[ -z "$input" ]]; then
        echo "Usage: mmd-pdf <input.mmd> [output.pdf] [width]"
        return 1
    fi

    mmdc -i "$input" -o "$output" ${width:+-w "$width"}
    echo "Created: $output"
}

# Watch a mermaid file and auto-render on changes
mmd-watch() {
    local input="$1"
    local output="${2:-${input%.*}.png}"
    local width="$3"

    if [[ -z "$input" ]]; then
        echo "Usage: mmd-watch <input.mmd> [output.png] [width]"
        return 1
    fi

    echo "Watching $input for changes..."
    fswatch -o "$input" | while read -r; do
        echo "Change detected, rendering..."
        mmdc -i "$input" -o "$output" ${width:+-w "$width"}
        echo "Updated: $output"
    done
}


# =============================================================================
# Jupyter Helpers
# =============================================================================

# Start Jupyter Lab in current directory
alias jlab='jupyter lab'

# Start Jupyter Lab without opening browser
alias jlab-nb='jupyter lab --no-browser'

# Start classic notebook
alias jnb='jupyter notebook'

# List running Jupyter servers
alias jlist='jupyter server list'

# Stop all Jupyter servers
alias jstop='jupyter server stop'

# Convert notebook to various formats
# Usage: nbconvert <notebook.ipynb> [format]
nbconvert() {
    local notebook="$1"
    local format="${2:-html}"

    if [[ -z "$notebook" ]]; then
        echo "Usage: nbconvert <notebook.ipynb> [format]"
        echo "Formats: html, pdf, markdown, script, slides"
        return 1
    fi

    jupyter nbconvert --to "$format" "$notebook"
}

# Execute a notebook and save output
# Usage: nbexec <notebook.ipynb>
nbexec() {
    local notebook="$1"

    if [[ -z "$notebook" ]]; then
        echo "Usage: nbexec <notebook.ipynb>"
        return 1
    fi

    jupyter nbconvert --execute --to notebook --inplace "$notebook"
    echo "Executed: $notebook"
}

# Create a new notebook with a Python kernel
nbnew() {
    local name="${1:-untitled}"
    local notebook="${name}.ipynb"

    if [[ -f "$notebook" ]]; then
        echo "File already exists: $notebook"
        return 1
    fi

    cat > "$notebook" <<'EOF'
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "name": "python",
   "version": "3.11.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

    echo "Created: $notebook"
}

