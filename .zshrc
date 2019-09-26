# enable # in terminal
setopt interactivecomments

# export MANPATH="/usr/local/man:$MANPATH"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

export EDITOR='vim'
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# https://unix.stackexchange.com/a/111777/214305
# http://zsh.sourceforge.net/Doc/Release/Options.html
export SAVEHIST=9999
export HISTSIZE=9999
export HISTFILE=~/.zsh_history
# instantly append history to the file (incappendhistory) would nullify histignorealldups's effort,
# as it removes duplicate from the list but not the file, so use default: append but not incappend
# setopt incappendhistory
setopt histignorealldups

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug plugins/git, from:oh-my-zsh
zplug plugins/tmux, from:oh-my-zsh
zplug plugins/wd, from:oh-my-zsh
# zplug plugins/sudo, from:oh-my-zsh
# zplug plugins/command-not-found, from:oh-my-zsh
zplug themes/robbyrussell, from:oh-my-zsh

zplug hlissner/zsh-autopair, use:autopair.zsh
zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-completions, use:src
zplug chriskempson/base16-shell, use:scripts/base16-solarized-light.sh
# zplug seebi/dircolors-solarized
zplug Vifon/deer, use:deer
if [ ${$(uname -s):0:6} != "CYGWIN" ]; then
    zplug junegunn/fzf
fi

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    echo; zplug install
fi
zplug load # --verbose

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

# prompt
# TODO this requires robbyrussell's theme, how to not?
export PROMPT='
[%{$fg[green]%}%n%{$reset_color%}@%m]
%{$fg[cyan]%}%~%{$reset_color%} '

# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
alias -g less='less -r'                          # raw control characters
alias -g le='less -r'
# alias whence='type -a'                        # where, of a sort
alias -g grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -al'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
# use .agignore
alias -g ag='ag -p ~/.agignore'

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
# alias -g A='| ag -p ~/.agignore'
alias -g hp='--help'
alias -g hl='--help | less -r'

alias res="source $HOME/.zshrc"
alias ren="nginx -s reload"
alias -g v="nvim"
alias -g e="emacsclient -n"
alias no="node -p"
alias odir="explorer ."
alias -- -="cd -"
alias ..="cd .."

# key bindings
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
bindkey -a '^A' vi-beginning-of-line
bindkey -a '^E' vi-end-of-line
bindkey -a '/' vi-history-search-forward
bindkey -a '?' vi-history-search-backward

# shadowsocks
# export http_proxy=http://127.0.0.1:1080

# disable flow control
stty -ixon

# https://superuser.com/a/398990/599147
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# start a emacs daemon for scripts etc.
# emacs -Q --daemon=maid

# auto added by install scripts:

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
