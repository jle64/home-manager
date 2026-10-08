alias ls='eza --group-directories-first --hyperlink --group --git --time-style long-iso'
alias tree='ls --tree -A --git-ignore'
alias l='ls'
alias l.='ls -ld .*'
alias lc='ls -1'
alias la='ls -lha'
alias ll='ls -lh'
alias lsd='ls -ail'
alias lx="ls -lhAxb"          # sort by extension
alias lk="ls -lhASr"          # sort by size, biggest last
alias lt="ls -lhAtr"          # sort by date, most recent last
alias g="egrep -i"
alias e="emacs -nw"
alias vi="nvim"
alias vim="nvim"
alias sudo="sudo "            # allow to perform alias expansion
if which gio >/dev/null 2>&1; then
	alias open="gio open"
	alias trash="gio trash"
elif which xdg-open >/dev/null 2>&1; then
	alias open="xdg-open"
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

if [ "$(uname)" = "Linux" ]; then
	alias dmesg="dmesg -T"
fi

### Color ###

alias ip="ip -c"

for cmd in grep egrep fgrep diff; do
	if $cmd --version 2>/dev/null | grep -q GNU; then
		alias $cmd="$cmd --color"
	fi
done
