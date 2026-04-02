# path
if ! echo $PATH | grep -q $HOME/.local/bin; then
	export PATH=$PATH:$HOME/.local/bin
fi

# apps
export EDITOR=nvim
export BROWSER=firefox
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python

if [ -n "$KATE_PID" ]
then
	export GIT_EDITOR="kate -b"
elif [ -n "$VSCODE_PID" ]
then
	export GIT_EDITOR="code --wait"
fi

# don't read mail
unset MAILCHECK

# colors
export CLICOLOR=true

# jupyterlab console doesn't mix well with fancy stuff
if test -n "$JPY_PARENT_PID"; then
	export TERM=dumb
fi
