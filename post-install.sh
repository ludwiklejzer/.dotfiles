#!/bin/sh

# Arch Linux Post-Install Script
# https://github.com/Lajck/dotfiles/post-installer
# by Lajck

# Stop the script in case of some error
set -euo pipefail

# Text properties
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RED=$(tput setaf 1)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# System support
if [ "$(uname -n)" != archlinux ]; then
	clear
	echo 'Sorry, your system is not supported.'
	exit 1
fi

clear
echo "Testing internet connection"
if [ "$(ping -c 1 -q google.com > /dev/null; echo $?)" != 0 ]; then
	echo "${RED}Please, connect to some network${RESET}"
	exit 1
fi

pacman_packages=(
	alacritty
	android-tools
	feh
	git
	xorg
	xorg-xinit
	qemu
	bspwm
	sxhkd
	os-prober
	ntfs-3g
	zsh
	pipewire
	pipewire-pulse
	wireplumber
	pulsemixer
	exa
	jq
	stow
	ffmpeg
	rofi
	unclutter
	neofetch
	neovim
	fzf
	libnotify
	dunst
	qbittorrent
	mpv
	ueberzug
	redshift
	zathura
	zathura-djvu
	zathura-pdf-mupdf
 	noto-fonts-emoji
 	noto-fonts-cjk
	ranger
	p7zip
	unzip
	zip
	unrar
	htop
	xsel
	the_silver_searcher
	ripgrep-all
	z
	python-pywal
	polybar
	youtube-dl)

aur_packages=(
	pick-colour-picker
	asdf-vm
	picom-animations-git
	jmtpfs
	pandoc-bin)

npm_global_packages=(
	vscode-langservers-extracted
	cssmodules-language-server
	bash-language-server
	prettier)

pacman_install() {
	clear

	# Root privileges test.
	if [ "$UID" != 0 ]; then
		echo "${RED}To install packages from Pacman you must execute this script with sudo privileges${RESET}"
		exit 1
	fi

	echo "${BOLD}Updating package list...${RESET}"
	pacman -Sy --noconfirm > /dev/null 
	sleep 1

	echo "${BOLD}Upgrading system packages...${RESET}"
	pacman -Su --noconfirm > /dev/null
	sleep 1

	echo "${BOLD}Installing Pacman packages...${RESET}"
	pacman -S "${pacman_packages[@]}" --noconfirm > /dev/null
	sleep 1
}

aur_install() {
	# Root privileges test.
	if [ "$UID" = 0 ]; then
		echo "${RED}Please do not install packages from AUR using root${RESET}"
		exit 1
	fi

	echo "${BOLD}Installing YAY...${RESET}"
	git clone https://aur.archlinux.org/yay.git > /dev/null
	cd yay && makepkg -si --noconfirm && cd - && rm -rf yay

	echo "${BOLD}Installing AUR packages...${RESET}"
	yay -S "${aur_packages[@]}" --noconfirm  > /dev/null
}

npm_install() {
	if command -v node &>/dev/null; then
		echo "${BOLD}Installing NPM global packages..."
		npm install -g "${npm_global_packages[@]}" > /dev/null
	else
		echo "You need to install NodeJS"
	fi
}

dotfiles_install() {
	clear
	echo "${BOLD}Creating${RESET} ~/.config"
	mkdir -p ~/.config
	echo "${BOLD}Cloning repository${RESET} https://github.com/Lajck/dotfiles.git"
	git clone https://github.com/Lajck/dotfiles.git ~/dotfiles
	echo "${BOLD}Creating symlinks${RESET}"
	cd ~/dotfiles && stow -vt ~ main-config  && cd -
	sleep 1
}

chose_install() {
	case $INSTALLATION_NUMBER in 
		1) 
			clear
			echo -e "${BOLD}${GREEN}|${RESET} ${BOLD}PACMAN${RESET}\n"
			echo -e "${pacman_packages[*]}\n"

			read -p "Do you really want to install these packages? ${BOLD}[y/n] ${RESET}" confirm

			confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
			if [ "$confirm" != "y" ]; then exit 1; fi
			pacman_install
		;;
		2)
			clear
			echo -e "${BOLD}${GREEN}|${RESET} ${BOLD}AUR${RESET}\n"
			echo -e "${aur_packages[*]}\n"

			read -p "Do you really want to install these packages? ${BOLD}[y/n] ${RESET}" confirm

			confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
			if [ "$confirm" != "y" ]; then exit 1; fi
			aur_install
		;;
		3)
			clear
			echo -e "${BOLD}${GREEN}|${RESET} ${BOLD}NPM${RESET}\n"
			echo -e "${npm_global_packages[*]}\n"

			read -p "Do you really want to install these packages? ${BOLD}[y/n] ${RESET}" confirm

			confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
			if [ "$confirm" != "y" ]; then exit 1; fi
			npm_install
		;;
		4)
			clear
			echo -e "${BOLD}${GREEN}|${RESET} ${BOLD}DOTFILES${RESET}\n"

			read -p "Do you really want to set up the dotfiles? ${BOLD}[y/n] ${RESET}" confirm

			confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
			if [ "$confirm" != "y" ]; then exit 1; fi
			dotfiles_install
		;;
		*)
			echo "Invalid Value"
			sleep 2
			display_options
		;;
	esac

	echo -e "\n${BOLD}${GREEN}Done!${RESET}"
	exit 0
}

display_options() {
	clear
	cat <<EOL
${BOLD}Select a ${GREEN}NUMBER${RESET} ${BOLD}to proceed the installation of the packages${RESET}

${BOLD}${GREEN}|${RESET} ${BOLD}1 - PACMAN${RESET}
${BOLD}${GREEN}|${RESET} ${BOLD}2 - AUR${RESET}
${BOLD}${GREEN}|${RESET} ${BOLD}3 - NPM${RESET}
${BOLD}${GREEN}|${RESET} ${BOLD}4 - DOTFILES${RESET}

EOL
	read -p "${BOLD}${GREEN}>${RESET} " INSTALLATION_NUMBER
	chose_install
}

display_options
