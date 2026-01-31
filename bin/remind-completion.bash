#!/bin/bash
# Bash completion for remind command

_remind_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # If we're completing the first argument (time)
    if [ $COMP_CWORD -eq 1 ]; then
        # Suggest common time formats
        local times="1m 5m 10m 15m 30m 1h 2h 30s 1h30m"
        COMPREPLY=( $(compgen -W "$times" -- "$cur") )
        return 0
    fi
    
    # If we're completing the second argument (message)
    if [ $COMP_CWORD -eq 2 ]; then
        # Common reminder messages
        local messages="\"meeting starts\" \"deployment complete\" \"check email\" \"lunch break\" \"call back\" \"take a break\""
        COMPREPLY=( $(compgen -W "$messages" -- "$cur") )
        return 0
    fi
}

complete -F _remind_complete remind
