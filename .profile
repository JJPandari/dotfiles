# xserver
export DISPLAY=:0
export NO_AT_BRIDGE=1

# input method
export LC_ALL="en_US.UTF-8"
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# rvm
export PATH="$PATH:$HOME/.rvm/bin"

# jenv
if [ -d "$HOME/.jenv" ]; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
