alias --save summon="run0 pacman -S"

alias --save banish="run0 pacman -Rns"

function scry
    argparse 0 -- $argv; or return

    if set -q _flag_0
        pacman -Qs $argv
    else
        pacman -Ss $argv
    end
end
funcsave scry

function ponder
	argparse 0 -- $argv; or return

    if set -q _flag_0
        pacman -Qi $argv
    else
        pacman -Si $argv
    end
end
funcsave ponder

