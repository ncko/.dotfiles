# aliases
alias vim="nvim"
alias sed="gsed"
alias awk="gawk"
alias vimconfig="vim ~/.dotfiles/nvim/.config/nvim/lua/ncko"
alias vimbin="vim ~/.dotfiles/bin/.local/bin"
alias vimcfbin="vim ~/projects/ncko/crossfit/.local/bin"
alias vimdot="vim ~/.dotfiles"
alias commitrand='git commit -m "$(curl -sk http://whatthecommit.com/index.txt)"'

alias youtube-dl-best='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" '
alias youtube-dl-480='youtube-dl -f "bestvideo[height<=480][ext=mp4]+bestaudio[ext=m4a]" '
alias youtube-dl-720='youtube-dl -f "bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]" '
alias youtube-dl-4k='echo -e "This will transcode the video from webm to h264 which could take a long time\n\n"; youtube-dl -f "bestvideo[ext=webm]+bestaudio[ext=m4a]" --recode-video mp4 '
alias youtube-dl-mp3='youtube-dl --extract-audio -f bestaudio[ext=mp3] --no-playlist '

# save last command
alias slc="fc -ln -1 | sed 's/^\*//' >> $HOME/.cache/ncko/saved_cmds"
# grep saved commands
alias slg="< $HOME/.cache/ncko/saved_cmds grep"

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% --layout reverse | xargs tldr'

# key bindings
bindkey -s ^f "tms\n"
bindkey '^ ' autosuggest-accept
