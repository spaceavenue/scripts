function dotfiles --wraps='git --git-dir=$HOME/projects/dotfiles --work-tree=$HOME' --wraps=git --description 'dotfiles git alias'
    git --git-dir=$HOME/projects/dotfiles --work-tree=$HOME $argv
end
funcsave dotfiles

function run0 --wraps "run0"
	command run0 --background= $argv
end
funcsave run0
