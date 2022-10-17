export PATH=$HOME/Library/Python/3.9/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$PATH:/Users/ncko/.cargo/bin

# Created by `pipx` on 2021-10-11 05:20:52
export PATH="$PATH:/Users/$USER/.local/bin"

###
# NVM
###
# takes forever to load
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://medium.com/@kinduff/automatic-version-switch-for-nvm-ff9e00ae67f3#:~:text=The%20automatic%20switch%20will%20switch,shell%20to%20make%20this%20work.
# takes forever to load whenever you change directories or open a new terminal
# so disabling for now
#autoload -U add-zsh-hook
#load-nvmrc() {
    #if [[ -f .nvmrc && -r .nvmrc ]]; then
        #nvm use
    #elif [[ $(nvm version) != $(nvm version default)  ]]; then
        #echo "Reverting to nvm default version"
        #nvm use default
    #fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc

# vi mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# per-machine environment vars
if [[ -f ./machine.zsh ]]; then
    source ./machine.zsh
fi

# Load pyenv automatically
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# load pyenv-virtualenv automatically
# eval "$(pyenv virtualenv-init -)"
#

# aws tab completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

