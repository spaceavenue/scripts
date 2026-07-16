alias --save dot-conf="git -C ~/.config"
alias --save dot-script="git -C ~/.local/bin/"

alias --save run0="run0 --background="
alias --save uwu="run0" # :3

# add a config file blease
alias --save eza="eza --long --all --reverse --sort modified --binary --time modified --time-style '+%Y-%m-%d %H:%M' --icons=always --git"

# bat-extras eat your heart out
function batman --wraps 'man'
	set -lx MANROFFOPT "-c"
	set -l BAT_OPTS --language=man --paging=always --style=grid
	set -lx MANPAGER "sh -c 'col -bx | bat $BAT_OPTS'"
	command man $argv
end
funcsave batman

alias --save bless="bat -p --paging=always"
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

alias --save ytm-album="yt-dlp --format=\"ba[ext=m4a]\"/ba --extract-audio --audio-format m4a --no-overwrites --embed-metadata --embed-thumbnail --ppa \"ThumbnailsConvertor:-lavfi crop=ih:ih\" -o \"%(album)s/%(track_number,playlist_index)s %(title)s.%(ext)s\""
