# Load bashrc if it exists
if [ -f $HOME/.bashrc ]; then
source $HOME/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash

export DOCKER_HOST='unix:///var/run/docker.sock'
