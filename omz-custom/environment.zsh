export PATH=$HOME/Library/Python/3.8/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Created by `pipx` on 2021-10-11 05:20:52
export PATH="$PATH:/Users/$USER/.local/bin"

# load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




# vi mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
