export ZSHDIR=$HOME/.config/zsh
export PATH=$HOME/bin:$PATH
export FPATH=$FPATH:$ZSHDIR/pure
export HISTFILE=$HOME/.zsh_history
export OS="$(uname -s)"
#export TERM=xterm-256color
export EDITOR=nano
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTORY_IGNORE="(l *|la *|ls *|cd|cd *|rm *|echo *|find *|cat *|ccat *|apt*|mkdir *|rmdir *|rsync *|git *|nano *|screen *|traceroute *|ping *|whois *|md5sum *|timeout *|tmux *|mount *|openssl *|watch *|dpkg *|chown *|mv *|cp *|grc *|scp *|tail *|wget *|zcat *|time *|curl *|while *|unp *|attr *|dialog *|sysbench *|ftp *|truncate *|ln *|grep *|chmod *|*grep*|man *|pidof *|nslookup *|umount *|sleep *|pushd *| popd *|kill *|su *|tar *|touch *|7z *|hexdump *|du|du *|ack *|\\\\*)"
setopt hist_reduce_blanks hist_ignore_space hist_ignore_all_dups interactive_comments share_history

alias ..="cd .."
alias ff="find . -type f -iname"
alias fd="find . -type d -iname"
alias nolog="unset HISTFILE"
alias grep="grep --color=auto"
alias cdu="cdu.pl -sridh"
alias l="k -h --no-vcs --group-directories-first"
alias la="k -h -A --no-vcs --group-directories-first"
alias bell='echo -en "\007"'
if [ "$OS" = "Linux" ]; then
alias rm="rm -I"
alias update="sudo apt-get update && sudo apt-get upgrade; sudo apt-get clean"
elif [ "$OS" = "Darwin" ]; then
alias update="brew update && brew upgrade"
fi

function cheat         { curl cheat.sh/$1 }
function mcd           { mkdir -p $1; cd $1 }
function pw            { echo `tr -dc ACDEFHJKLMNPRTUVWX </dev/urandom | head -c1``pwgen -AnBs 23 1` | fold -w4 | paste -sd'-' - }
function precmd        { print -Pn "\e]2;%m (%~)\a\e]1;%m\a"; }
function _force_rehash { (( CURRENT==1 )) && rehash; return 1 }

bindkey -e
bindkey '^R'      history-incremental-search-backward
bindkey '^[[5~'   up-line-or-history
bindkey '^[[6~'   down-line-or-history
bindkey '^[[A'    up-line-or-search
bindkey '^[[B'    down-line-or-search
bindkey '^[[H'    beginning-of-line
bindkey '^[[1~'   beginning-of-line
bindkey '^[[F'    end-of-line
bindkey '^[[4~'   end-of-line
bindkey '^[[Z'    reverse-menu-complete
bindkey '^[[3~'   delete-char
bindkey '^[3;5~'  delete-char
bindkey '^[m'     copy-prev-shell-word
bindkey '^[k'     history-beginning-search-backward
bindkey '^[j'     history-beginning-search-forward
bindkey '^[^I'    _history-complete-older
bindkey '^[^[^I'  _history-complete-newer
bindkey '^U'      backward-kill-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5A" beginning-of-line
bindkey "^[[1;5B" end-of-line

autoload -Uz promptinit && promptinit && prompt pure
autoload -Uz compinit   && compinit   && zmodload -i zsh/complist

# ...*:corrections'  format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
#zstyle ':completion:::::'                completer _force_rehash _complete _approximate
zstyle ':completion:::::'                 completer _expand _complete _prefix _ignored _approximate
zstyle -e ':completion:*:approximate:*'   max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:corrections'        format "- %d - (errors %e})"
zstyle ':completion:*'                    menu select
zstyle ':completion:*'                    group-name ''
zstyle ':completion:*:descriptions'       format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:warnings'           format " ${c160}-- no matches found --%f"
zstyle ':completion:*:hosts'              hosts ${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}
zstyle ':completion:*:users'              ignored-patterns '_*' 'Guest' 'daemon' 'nobody'
zstyle ':completion:*:(scp|rsync):*'      group-order hosts users files all-files
#zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:*:*:processes'    command "ps -u `whoami`"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*'           menu yes select
zstyle ':completion:*:*:kill:*'           force-list always
zstyle ':completion:*:*:kill:*'           insert-ids single
zstyle ':completion:*:manuals'            separate-sections true
zstyle ':completion:*:manuals.(^1*)'      insert-sections true
zstyle ':prompt:pure:prompt:success'      color cyan

source $ZSHDIR/grc.zsh
source $ZSHDIR/k/k.plugin.zsh
source $ZSHDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -d "$HOME/bin/ImageMagick-7.0.1" ]]; then export MAGICK_HOME="$HOME/bin/ImageMagick-7.0.10"; export PATH="$PATH:$MAGICK_HOME/bin"; export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"; fi
# $ZSHDIR/stats.sh
