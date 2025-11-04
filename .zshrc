#----------------------------------------------------------------------------
# global env
#----------------------------------------------------------------------------
# export MANPATH="/usr/local/man:$MANPATH"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

#----------------------------------------------------------------------------
# command history
#----------------------------------------------------------------------------
# https://unix.stackexchange.com/a/111777/214305
# http://zsh.sourceforge.net/Doc/Release/Options.html
export SAVEHIST=9999
export HISTSIZE=9999
export HISTFILE=~/.zsh_history
# instantly append history to the file (incappendhistory) would nullify histignorealldups's effort,
# as it removes duplicate from the list but not the file, so use default: append but not incappend
# setopt incappendhistory
setopt histignorealldups
setopt share_history # different shells can share history

#----------------------------------------------------------------------------
# key bindings
#----------------------------------------------------------------------------
# -v: insert mode -a: normal mode

bindkey -v
bindkey -v '^A' vi-beginning-of-line
bindkey -v '^E' vi-end-of-line
bindkey -v '^P' up-line-or-history
bindkey -v '^N' down-line-or-history
bindkey -v '^F' vi-forward-char
bindkey -v '^D' vi-backward-char
bindkey -v '^Q' vi-quoted-insert
bindkey -v '^S' history-incremental-search-forward
# let fzf do this
# bindkey -v '^R' history-incremental-search-backward
bindkey -v '^B' delete-char
bindkey -v '^K' kill-line
bindkey -v '^[f' emacs-forward-word
bindkey -v '^[d' emacs-backward-word
bindkey -v '^[b' kill-word
bindkey -v '^_' undo
bindkey -v '^[n' down-history
bindkey -v '^[p' up-history

bindkey -a '/' vi-history-search-forward
bindkey -a '?' vi-history-search-backward

#----------------------------------------------------------------------------
# plugins with zplug
#----------------------------------------------------------------------------
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug hlissner/zsh-autopair, use:autopair.zsh
zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions, use:src
zplug chriskempson/base16-shell, use:scripts/base16-solarized-light.sh
# zplug seebi/dircolors-solarized
zplug Vifon/deer, use:deer
if [ ${$(uname -s):0:6} != "CYGWIN" ]; then
    zplug junegunn/fzf
fi
# let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    echo; zplug install
fi
zplug load # --verbose

# NOTE: vi mode need to be set before loading fzf bindings
if [ ${$(uname -s):0:6} != "CYGWIN" ]; then
    if [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    else
        ~/.zplug/repos/junegunn/fzf/install
    fi

    FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules"
    export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
    export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
    export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
    export FZF_CTRL_T_OPTS='--exact'
    export FZF_CTRL_R_OPTS='--exact'
    export FZF_ALT_C_OPTS='--exact'
    alias -g F='$(fzf --exact)'
fi

autoload -U deer
zle -N deer
bindkey -v '^[j' deer
bindkey -a '^[j' deer
typeset -Ag DEER_KEYS
DEER_KEYS[page_down]='d'
DEER_KEYS[page_up]='u'
DEER_KEYS[filter]=''

# DIR_COLOR_SOLAR="$HOME/.zgen/seebi/dircolors-solarized-master/dircolors.ansi-light"
# [[ -f $DIR_COLOR_SOLAR ]] && eval `dircolors $DIR_COLOR_SOLAR`

#----------------------------------------------------------------------------
# functions
#----------------------------------------------------------------------------
# go to emacs with current context in terminal
# https://github.com/xuchunyang/emacs.d/blob/master/misc/emacs.sh

mg() {
    emacsclient -n -e '(magit-status)' -e '(open-emacs-window)' > /dev/null
}

dr() {
    if [ ${$(uname -s):0:6} = "CYGWIN" ]; then
        WORKING_DIR=$(cygpath -m `pwd`)/.
    else
        WORKING_DIR=$(pwd)/.
    fi
    # adding /. prevents elisp from stripping out the last segment
    emacsclient -n -e '(deer "'"$WORKING_DIR"'")' -e '(open-emacs-window)' > /dev/null
}

calc ()
{
    emacs -Q --batch --eval "(message \"%s\" (calc-eval \"$1\"))"
}

# use current path when opening files in emacs term
#
# INSIDE_EMACS 则是 Emacs 在创建 term/shell/eshell 时都会带上的环境变量
# 通常 shell/tramp 会将 TERM 环境变量设置成
# dumb，所以这里要将他们排除。
#
# shell 下的目录同步不采用这种方式
function precmd() {
    if [[ -n "$INSIDE_EMACS" && "$TERM" != "dumb" ]]; then
        echo -e "\033AnSiTc" "$(pwd)"
        echo -e "\033AnSiTh" $(hostname -f)
        echo -e "\033AnSiTu" "$LOGNAME"
    fi
}

# for emacs vterm
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

#----------------------------------------------------------------------------
# prompt
#----------------------------------------------------------------------------
export PROMPT='
[%F{green}%n%f@%m] %D{%H:%M:%S}
%F{cyan}%~%f '

#----------------------------------------------------------------------------
# aliases
#----------------------------------------------------------------------------
# Default to human readable figures
alias df='df -h'
alias du='du -h'
alias -g less='less -r'                          # raw control characters
alias -g le='less -r'
# alias whence='type -a'                        # where, of a sort
alias -g grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
# Some shortcuts for different directory listings
alias ls='ls -FG'                 # classify files in colour
alias ll='ls -alhG'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#common-aliases
alias zshrc="$EDITOR ~/.zshrc"
alias -g L='| less -r'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| rg -S'
alias -g LL='2>&1 | less -r'
alias -g CA='2>&1 | cat -A'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
# alias -g A='| ag'
alias -g hp='--help'
alias -g hl='--help | less -r'

alias res="source $HOME/.zshrc"
alias ren="nginx -s reload"
alias v="nvim"
alias e="emacsclient -n"
alias no="node -p"
alias odir="explorer ."
alias -- -="cd -"
alias ..="cd .."

alias tlist='tmux list-sessions'
alias tnew='tmux new-session -s'
alias tattach='tmux attach -t'
alias tkill='tmux kill-session -t'

#----------------------------------------------------------------------------
# options etc.
#----------------------------------------------------------------------------
# enable # in terminal
setopt interactivecomments

# proxy
# export http_proxy=http://127.0.0.1:1080

# disable flow control
stty -ixon

# work configs
[[ -e ~/.privaterc ]] && source ~/.privaterc

# https://superuser.com/a/398990/599147
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

alias ema='open -n /Applications/Emacs.app'
# start a emacs daemon for scripts etc.
alias emaid='EMACS_SOCKET=maid open -n /Applications/Emacs.app'
alias -g em="emacsclient -n -s maid"
# emacs -Q --daemon=maid

# for emacs vterm ; needs to be at end
vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
