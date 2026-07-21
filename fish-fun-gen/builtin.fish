#!/usr/bin/env fish

fish_add_path "$HOME"/.local/bin/prog "$HOME"/.local/bin

function fish_greeting
end
funcsave fish_greeting

function fish_config
end
funcsave fish_config

function fish_prompt
    set -l last_status $status

    set_color normal
    echo -n '['

    set_color -b normal f38ba8 --bold
    echo -n $USER
    
    set_color normal cba6f7
    echo -n ' on '
    
    set_color normal ffd1db --bold
    echo -n (prompt_hostname)
    
    set_color normal cba6f7
    echo -n ' in '(prompt_pwd)

    set -g __fish_git_prompt_showcolorfeatures true
    set -g __fish_git_prompt_color_branch f38ba8 --bold
    set -g __fish_git_prompt_char_stateseparator ' '
    
    fish_git_prompt
    
    set_color normal
    echo -n ' ] '
end
funcsave fish_prompt

function fish_command_not_found
    echo "*hand wave* `$argv[1]` is not the command you're looking for."
end
funcsave fish_command_not_found
