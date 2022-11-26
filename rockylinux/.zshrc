# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/luizlazaro/.oh-my-zsh"
ZSH_THEME="rockylinux"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
alias vim="nvim"
alias myip='ip -br -c a && echo "\n\033[91mPublic IP\033[0m" && curl https://ip.me/'

# CONSOLE COLORS
if [ "$TERM" = "linux" ]; then
	echo -en "\e]P0111111" #black
	echo -en "\e]P82B2B2B" #darkgrey
	echo -en "\e]P1D75F5F" #darkred
	echo -en "\e]P9DE8692" #red
	echo -en "\e]P27ECA9C" #darkgreen
	echo -en "\e]PAA3BE8C" #green
	echo -en "\e]P3D7AF87" #brown
	echo -en "\e]PBEBCB8B" #yellow
	echo -en "\e]P461AFEF" #darkblue
	echo -en "\e]PC81A1C1" #blue
	echo -en "\e]P5C882E7" #darkmagenta
	echo -en "\e]PDC882E7" #magenta
	echo -en "\e]P6A3B8EF" #darkcyan
	echo -en "\e]PEA3B8EF" #cyan
	#echo -en "\e]P7E5E5E5" #lightgrey
	echo -en "\e]P77ECA9C" #lightgrey turned into darkgreen
	echo -en "\e]PFC5C8C6" #white
	clear #for background artifacting
fi

# Env Variables
export TERM=linux
export EDITOR=nvim
export LANG=en_US.UTF-8
