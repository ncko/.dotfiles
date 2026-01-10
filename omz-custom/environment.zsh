#export PATH=$HOME/Library/Python/3.9/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export PATH=$PATH:$HOME/.cargo/bin
export PATH=/opt/homebrew/opt/sqlite/bin:$PATH
export PATH=/opt/homebrew/opt/libpq/bin:$PATH

# Created by `pipx` on 2021-10-11 05:20:52
export PATH="/Users/$USER/.local/bin:$PATH"
export PATH=$PATH:$GEM_HOME/bin
export PATH=$PATH:$HOME/go/bin
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"



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
complete -C "$(which aws_completer)" aws

export EDITOR=nvim


###
# Mise
###

export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command $HOME/.local/bin/mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command $HOME/.local/bin/mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command $HOME/.local/bin/mise "$command" "$@"
}

_mise_hook() {
  eval "$($HOME/.local/bin/mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if [[ "$1" != "mise" && "$1" != "mise-"* ]] && $HOME/.local/bin/mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi
