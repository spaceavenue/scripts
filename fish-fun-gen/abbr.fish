function fish_user_key_bindings
	# paru
	abbr -a pars 'paru -Ss'    # aur package search
	abbr -a pari 'paru -Si'   # aur package info
	abbr -a psize 'paru -Ps' # system package size
	
	abbr -a kill-orphans 'pacman -Qdtq | doas pacman -Rns -- -'  # remove orphans

	# sudo -> uwu (which is just run0 lmao)
	abbr -a sudo uwu

	# better utils
	abbr -a cd 'z'
	abbr -a cdl 'zl'

	abbr -a cat 'bat'
	abbr -a man 'batman'

	abbr -a l 'eza'
	abbr -a cl 'clear; eza'

	abbr -a mv 'mv -vi'
	abbr -a cp 'cp -avi'

	abbr -a rm 'rm -Irv'
	abbr -a rmf 'rm -frv'

	abbr -a grep 'rg'

	abbr -a lsblk 'lsblk -p -o NAME,FSTYPE,LABEL,FSUSE%,FSUSED,FSSIZE,MOUNTPOINTS'

	# convenience
	abbr -a gc   'git clone'
	abbr -a gp	 'git push'
	abbr -a gpl  'git pull'
	abbr -a gplr 'git pull --rebase'
	abbr -a gri	 'git rebase -i'

	abbr -a b btop
	abbr -a sb 'uwu btop'

	abbr -a bt 'bluetoothctl connect'
	abbr -a btdc 'bluetoothctl disconnect'
	# abbr -a wificon 'nmcli device wifi connect'
	# abbr -a wifilist 'nmcli device wifi list'

	abbr -a usystemctl 'systemctl --user'
	abbr -a ujournalctl 'journalctl --user'
end
funcsave fish_user_key_bindings
