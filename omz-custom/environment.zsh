# PATH Configuration
path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /opt/homebrew/opt/sqlite/bin
    /opt/homebrew/opt/libpq/bin
    /opt/homebrew/opt/mysql-client/bin
    $HOME/.local/bin
    $path
    $HOME/.cargo/bin
    $HOME/go/bin
)
export PATH



if [[ -f ~/.config/crossfit/environment.zsh ]];
then
    source ~/.config/crossfit/environment.zsh
fi

# per-machine environment vars
if [[ -f $ZSH_CUSTOM/machine.zsh ]]; then
    source $ZSH_CUSTOM/machine.zsh
fi


# vi mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true



# aws tab completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C "$(which aws_completer)" aws

export EDITOR=nvim


###
# Mise (runtime version manager)
###
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
