# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
alias vimconfig="vim ~/.dotfiles/nvim/.config/nvim/lua/ncko"
alias vimbin="vim ~/.dotfiles/bin/.local/bin"
alias vimcfbin="vim ~/projects/ncko/crossfit/.local/bin"
alias vimdot="vim ~/.dotfiles"
alias commitrand='git commit -m "$(curl -sk http://whatthecommit.com/index.txt)"'

# save last command
alias slc="fc -ln -1 | sed 's/^\*//' >> $HOME/.cache/ncko/saved_cmds"
# grep saved commands
alias slg="< $HOME/.cache/ncko/saved_cmds grep"

# key bindings
bindkey -s ^f "tms\n"
bindkey '^ ' autosuggest-accept
