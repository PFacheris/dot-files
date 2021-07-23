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
alias sudo='sudo -E'
