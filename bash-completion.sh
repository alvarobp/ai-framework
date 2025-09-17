#!/bin/bash

# Bash completion for the 'ai' command

_ai_completion() {
    local cur prev words cword
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD

    if [[ $cword -eq 1 ]]; then
        # First argument: suggest main commands
        COMPREPLY=($(compgen -W "daily newsletters youtube" -- "$cur"))
    elif [[ $cword -eq 2 ]]; then
        # Second argument: depends on first argument
        case "${COMP_WORDS[1]}" in
            "daily"|"newsletters")
                COMPREPLY=($(compgen -W "digest read" -- "$cur"))
                ;;
        esac
    fi

    return 0
}

# Register the completion function for the 'ai' command
complete -F _ai_completion ai