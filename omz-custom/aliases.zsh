# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
alias vimconfig="vim ~/.dotfiles/nvim/.config/nvim/lua/ncko"
alias vimbin="vim ~/.dotfiles/bin/.local/bin"
alias vimcfbin="vim ~/projects/ncko/crossfit/.local/bin"
alias vimdot="vim ~/.dotfiles"

# save last command
alias slc="fc -ln -1 | sed 's/^\*//' >> $HOME/.cache/ncko/saved_cmds"
# grep saved commands
alias slg="< $HOME/.cache/ncko/saved_cmds grep"

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% --layout reverse | xargs tldr'

alias services-vm="clear && ssh -t services 'cd ~/projects/ncko/services ; zsh'"

# key bindings
bindkey -s ^f "tms\n"
bindkey '^ ' autosuggest-accept

# gcc
#alias gcc="gcc-13"
#alias cc="gcc-13"
#alias g++="g++-13"
#alias c++="c++-13"
