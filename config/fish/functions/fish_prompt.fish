function fish_prompt
    set saved_status $status
    set prev_status $status
    tty|grep -q tty; and set tty tty; or set tty pts

    echo -n '┌─ '
    if not test $prev_status = 0
        set_color --bold white
        set_color --background red
        echo -n $prev_status
        set_color --background normal
        echo -n " "
    end
    if [ $USER = root ]
        set_color red
    else
        set_color green
    end
    echo -n $USER
    set -l host_hash (hostname | cksum | cut -d' ' -f1)
    set -l colors_count (tput colors)
    if test -z "$colors_count"; set colors_count 8; end
    set -l host_color_idx (math "1 + $host_hash % ($colors_count - 1)")

    tput setaf $host_color_idx
    echo -n @
    echo -n (hostname):
    set_color cyan
    echo -n (pwd|sed "s=$HOME=~=")

    if set -q GUIX_ENVIRONMENT
        set_color magenta
        echo -n " (guix)"
    end
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_hide_untrackedfiles 1
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    set -g __fish_git_prompt_char_upstream_prefix ""
    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚"
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_conflictedstate "✖"
    set -g __fish_git_prompt_char_cleanstate "✔"
    set_color magenta
    printf '%s ' (__fish_vcs_prompt)

    if test -f /run/reboot-required
        set_color red
        echo -n '[!]'
    end

    echo
    set_color normal
    for job in (jobs)
        set_color $retc
        if [ $tty = tty ]
            echo -n '; '
        else
            echo -n '│ '
        end
        set_color brown
        echo $job
    end
    set_color normal
    echo -n '└╼ '
    set_color normal
end
