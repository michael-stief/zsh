export EXA_COLORS="uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;23:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;245:fi=38;5;6;1:di=38;5;6:ex=38;5;1:xa=38;5;12:*.png=38;5;4:*.jpg=38;5;4:*.gif=38;5;4"
export SCREENRC=$HOME/.config/screen/screenrc
export BORG_PROGRESS="--stats --progress -v"

alias ..='cd ..'
alias ...='cd ../..'
alias dl='curl -JLORs'
alias bell='echo -en "\007\007"'
alias dig='dig +short +noshort'
alias cdu='cdu.pl -idhx'
alias grep='grep --color=auto'
alias hg='history 1 | grep -i '
alias nolog='unset HISTFILE'
alias getkey='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
alias rip='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias l='k -h --no-vcs --group-directories-first'
alias la='k -h -A --no-vcs --group-directories-first'
if (( $+commands[exa] )); then
  alias ls='exa -s filename --group-directories-first'
  alias l='exa -lg --git --color-scale -s filename --group-directories-first'
  alias la='l -a'
fi

function cheat    { curl cheat.sh/$1 }
function rrmdir   { find ${1:-.} -depth -type d -exec rmdir '{}' + }
function mkcd     { mkdir -p $1 && cd $1 }
function pw1      { LC_ALL=C < /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-64} }
function pw2      { LC_ALL=C < /dev/urandom tr -dc bcdfghjkmpqrtvwxyzCDFGHJKMPQRTVWXYZ234679 | head -c${1:-64} }
function pw3      { LC_ALL=C < /dev/urandom tr -dc CDFGHJKMPQRTVWXYZ234679 | head -c${1:-64} }
function precmd   { print -Pn '\e]2;%m (%~)\a\e]1;%m\a'; }

HISTORY_IGNORE='(..|...|/*|./*|[ *|[[ *|7z *|\\\\*|ack *|attr *|bell|bg|borg *|cat *|cd|cd *|chmod *|chown *|cp *|curl *|dialog *|dig *|du|du *|echo *|export *|fg|find *|for |git commit *|*grep *|hexdump *|hg *|kill *|l|l *|la|la *|ln *|ls *|man *|mcd *|md5 *|md5sum *|mkdir *|mount *|mv *|nano *|nolog|nslookup *|openssl *|pidof *|ping *|ping6 *|popd *|pushd *|rip *|rm *|rmdir *|rmdir *|rsync *|scp *|screen *|sleep *|sysbench *|tail *|tar *|time *|timeout *|touch *|traceroute *|truncate *|umount *|unp *|watch *|wget *|which *|while *|whois *|zcat *)'
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.config/zhistory
PPATH=$HOME/.local/share/zsh/plugins
FPATH=$FPATH:$PPATH/pure
setopt histignorealldups histignorespace histreduceblanks
setopt autocd nohup listpacked alwaystoend correct interactivecomments no_beep

# cache and completion
zstyle ':completion:*'                  complete-options true
zstyle ':completion:*'                  completer _complete _ignored _approximate
zstyle ':completion:*'                  menu select _complete _ignored _approximate
zstyle ':completion:*'                  rehash true
zstyle ':completion:*'                  squeeze-slashes true
zstyle ':completion:*'                  use-cache off
zstyle ':completion:*'                  verbose yes
zstyle ':completion:*:approximate:*'    max-errors 2 numeric
zstyle ':completion:*:complete:*'       matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# colors and messages
zstyle ':completion:*'                  list-colors '=*=0;38;5;249'
zstyle ':completion:*'                  list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*'                  select-prompt '%SAt %p: Scrolling active%s'
zstyle ':completion:*:corrections'      format '%F{cyan}%d%f %F{red}%e%f%F{cyan}:%f'
zstyle ':completion:*:descriptions'     format '%F{cyan}%d:%f'
zstyle ':completion:*:messages'         format '%F{orange}%d:%f'
zstyle ':completion:*:warnings'         format '%F{cyan}- no matches found -%f'
zstyle ':prompt:pure:prompt:success'    color cyan

# order and grouping
zstyle ':completion:*'                  file-list all
zstyle ':completion:*'                  group-name ''
zstyle ':completion:*'                  list-dirs-first true
zstyle ':completion:*:*:-subscript-:*'  tag-order indexes parameters
zstyle ':completion:*:expand:*'         tag-order all-expansions
zstyle ':completion:*:functions'        ignored-patterns '_*'
zstyle ':completion:*:manuals'          separate-sections true

# ssh and rsync
test -f $HOME/.ssh/config && \
zstyle ':completion:*:hosts'            hosts ${${${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}
zstyle ':completion:*:users'            ignored-patterns '_*' 'Guest' 'daemon' 'nobody'

# hotkeys
bindkey '^[[Z'    reverse-menu-complete # shift+tab
bindkey '^[OM'    accept-line           # fix return key over ssh
bindkey '^[[3~'   delete-char           # fix delete key over ssh

unalias run-help 2>/dev/null
autoload -Uz run-help
autoload -Uz compinit && compinit -D && zmodload -i zsh/complist
autoload -Uz promptinit && promptinit && prompt pure

source "$PPATH/k/k.plugin.zsh"
source "$PPATH/pure/pure.plugin.zsh"
source "$PPATH/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
source "$PPATH/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=024
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_HIGHLIGHT_STYLES[comment]=fg=245

(( $+commands[fortune] && $+commands[cowsay] && $+commands[lolcat] )) && echo && fortune -s | cowsay -f small | lolcat -r -v 1
