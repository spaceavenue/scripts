alias --save dot-conf="git -C ~/.config"
alias --save dot-script="git -C ~/.local/bin/"

alias --save run0="run0 --background="
alias --save uwu="run0" # :3

alias --save eza="eza --long --all --reverse --sort modified --binary --header --time modified --time-style '+%d %b %y %H:%M' --icons=always --git"

alias --save batman="batman --paging=always"

alias --save ncdu="ncdu -t16 --show-percent --exclude-kernfs"

alias --save bead="bat --line-range :\$argv[1]"
alias --save bail="bat --line-range -\$argv[1]:"

function funcdestroy --wraps "functions -e" --description "destroy a function"
	functions -e $argv
	for func in $argv
		funcsave $func
	end
end
funcsave funcdestroy

function zl --wraps "z" --description "cd into a dir and list contents"
	z $argv[1] && eza
end
funcsave zl

# only explicitly installed, official packages
alias --save dump-pkgs="pacman -Qenq | grep -vFx -f (pacman -Slq mine | psub) > ~/documents/arch_install.d/packages.txt"

alias --save pgraph="pacgraph -s -b '#180004' -l '#cba6f7' -t '#ffd1db' -d '#f38ba8' && sed 's/Monospace/Iosevka Etoile/g' -i pacgraph.svg && resvg -w 4000 pacgraph.svg pacgraph.png && rm -frv pacgraph.svg"
