# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH=/home/phpdev/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/wd
    # zgen oh-my-zsh plugins/sudo
    # zgen oh-my-zsh plugins/command-not-found
    zgen load hlissner/zsh-autopair
    zgen load zsh-users/zsh-syntax-highlighting
    # zgen load /path/to/super-secret-private-plugin

    # bulk load
#     zgen loadall <<EOPLUGINS
#         zsh-users/zsh-history-substring-search
#         # /path/to/local/plugin
# EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/robbyrussell

    # zgen load Vifon/deer
    # zgen load junegunn/fzf # install script doesn't recognize windows/cygwin

    # save all to init script
    zgen save
fi

# autoload -U deer
# zle -N deer
# bindkey -v '^H' deer
# bindkey -a '^H' deer
# typeset -Ag DEER_KEYS
# DEER_KEYS[page_down]='d'
# DEER_KEYS[page_up]='u'

# Base16 Shell
BASE16_SHELL="$HOME/.bash/colors/base16-solarized.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# go to emacs with current context in terminal
# https://github.com/xuchunyang/emacs.d/blob/master/misc/emacs.sh

mg() {
    emacsclient -n -e '(magit-status)' > /dev/null
}

dr() {
    # adding /. prevents elisp from stripping out the last segment
    emacsclient -n -e '(deer "'$(cygpath -m `pwd`)'/.")' -e '(open-emacs-window)' > /dev/null
}

calc ()
{
    emacs -Q --batch --eval "(message \"%s\" (calc-eval \"$1\"))"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
# use .agignore
alias ag='ag --path-to-agignore ~/.agignore'

# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#common-aliases
alias zshrc="$EDITOR ~/.zshrc"
alias -g L='| less -r'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep --color'
alias -g LL='2>&1 | less -r'
alias -g CA='2>&1 | cat -A'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g A='| ag --path-to-agignore ~/.agignore'
alias -g hp='--help'
alias -g hl='--help | less -r'
alias res="source $HOME/.zshrc"
alias v="vim"
alias e="emacsclient -n"
alias no="node -p"
alias odir="explorer ."

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
bindkey -v '^R' history-incremental-search-backward
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

# shadow socks
export http_proxy=http://127.0.0.1:1080

# disable flow control
stty -ixon

# playing with C
alias jj='gcc practice.c -o out.exe'
alias out='./out'
