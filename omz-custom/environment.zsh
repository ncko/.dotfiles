export PATH=$HOME/Library/Python/3.8/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Created by `pipx` on 2021-10-11 05:20:52
export PATH="$PATH:/Users/$USER/.local/bin"


###
# NVM
###
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://medium.com/@kinduff/automatic-version-switch-for-nvm-ff9e00ae67f3#:~:text=The%20automatic%20switch%20will%20switch,shell%20to%20make%20this%20work.
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc




# vi mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
