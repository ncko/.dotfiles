# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
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

