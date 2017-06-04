# OS Detection
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' || "$unamestr" == "Darwin" ]]; then
   platform='freebsd'
fi

# Custom Aliases
if [[ $platform == 'linux' ]]; then
    alias ll='ls -alF --color=auto'
elif [[ $platform == 'freebsd' ]]; then
    alias ll='ls -alGF'
else
    alias ll='ls -alF'
fi
alias grep='grep --color=auto --line-buffered'
alias ssh='sshdot'
alias sudo='sudo -E'

# Better bash history
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=
export HISTSIZE=

shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"

# Set Editor
which nvim &> /dev/null
if [ "$?" == "0" ]; then
    export EDITOR="nvim"
    alias vim='nvim'
    alias vi='nvim'
else
    export EDITOR="vim"
fi

# Set Linux Specific colors
LS_COLORS="di=34:ln=1;33:or=00;33:pi=35;5:ex=4;32:mi=00;31:*.tar=01;31:*.tgz=01;31:*.zip=01;31:*.gz=01;31:*.bz2=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.png=01;35:" ; export LS_COLORS

# Set Slack IRC Pass for ANX
export IRC_PASS="appnexus.1Vq19NcvBrz0dt6PJ3jo"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/sbin:/usr/share/apache-maven/bin"

# Source PS1
POWERLINE_HOME=$HOME
if [ ! -z ${SSHHOME+x} ]; then
    POWERLINE_HOME=$SSHHOME/.sshdot.d;
fi
source $POWERLINE_HOME/.powerline

# Load z
Z_PATH=$HOME/.sshdot.d
if [ ! -z ${SSHHOME+x} ]; then
    Z_PATH=$SSHHOME/.sshdot.d;
fi
source $Z_PATH/z.sh

# tmux refresh
if [ -n "$TMUX" ]; then
    function refresh() {
        export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
        export $(tmux show-environment | grep "^SSHHOME")
        export $(tmux show-environment | grep "^DISPLAY")
    }
else
    function refresh() {
        :
    }
fi
