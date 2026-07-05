alias --save summon="run0 pacman -S"

alias --save banish="run0 pacman -Rns"

function ponder --wraps "pacman -Ss"
    pacman -Ss $argv
end
funcsave ponder

function divine --wraps "pacman -Si"
    pacman -Si $argv
end
funcsave divine
