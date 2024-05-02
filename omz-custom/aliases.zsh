# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
alias vimconfig="vim ~/.dotfiles/nvim/.config/nvim/lua/ncko"
alias vimbin="vim ~/.dotfiles/bin/.local/bin"
alias vimcfbin="vim ~/projects/ncko/crossfit/.local/bin"
alias vimdot="vim ~/.dotfiles"
alias o="nvim \$(fd --exclude .git -H . | fzf --reverse --preview 'bat --color=always {}')"

# save last command
alias slc="fc -ln -1 | sed 's/^\*//' >> $HOME/.cache/ncko/saved_cmds"
# grep saved commands
alias slg="< $HOME/.cache/ncko/saved_cmds grep"

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% --layout reverse | xargs tldr'

alias services-vm="clear && ssh -t services 'cd ~/projects/ncko/services ; zsh'"
alias learnc="clear && ssh -t devstation1 'cd ~/projects/ncko/lcthw-c-project-files ; zsh'"

# key bindings
bindkey -s ^f "tms\n"
bindkey '^ ' autosuggest-accept

# gcc
#alias gcc="gcc-13"
#alias cc="gcc-13"
#alias g++="g++-13"
#alias c++="c++-13"

alias php7.2="docker run -it php:7.2-cli"
alias php7.4="docker run -it php:7.4-cli"
alias cfwebtest="docker run -it --mount type=bind,source=\"/Users/nick.olsen/projects/crossfit/cfweb\",target=/app cfweb vendor/bin/phpunit"
