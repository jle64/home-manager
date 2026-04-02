# set title
# adapted from http://v3.sk/~lkundrak/blog/entries/bashrc.html
set_title() {
	[ "$TERM" != "xterm-256color" ] && return
	TITLE="$@"

	if [ "$1" = fg ]
	then
		MATCH='^\[.*\]\+'
		[ -n "$2" ] && MATCH="$(echo $2 | sed 's/^%\([0-9]*\)/^\\[\1\\]/')"
		TITLE="$(jobs | grep "$MATCH" | sed 's/^[^ ]* *[^ ]* *//')"
	fi
	[ ! -z "$SSH_CONNECTION" ] && TITLE="[$USER@`hostname`] $TITLE"
	echo -ne "\e]0;$TITLE\007"
}
trap 'set +o functrace; set_title $BASH_COMMAND' DEBUG
PROMPT_COMMAND="history -a; set_title $SHELL"

---() {
        cd -3
}

cl() {
	cd "$1" && ls
}

md() {
	mkdir -p "$1" && cd "$1"
}

h() {
	test -z "$1" && history || history | egrep -i "$1"
}

theme() {
        . "${XDG_CONFIG_HOME}"/base16-shell/scripts/base16-"$1".sh
}

theme_rand() {
	theme `sort -R << EOF
	ashes
	atelier-heath
	atelier-lakeside
	bright
	codeschool
	harmonic-dark
	isotope
	monokai
	shapeshifter
	solarized-dark
	tomorrow
	solarized-light
	atelier-lakeside-light
EOF`
}