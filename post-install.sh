#!/bin/sh

# Arch Linux Post-Install Script
# https://github.com/ludwiklejzer/.dotfiles/post-installer
# by Ludwik Lejzer

# Stop the script in case of some error
set -eu

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

if [ ! "$(command -v jq)" ]; then
	clear
	printf "The %sjq%s program is necessary to proceed. Do you want to install it? %s[Y/n] %s" "${BLUE}" "${RESET}" "$BOLD" "$RESET"
	read -r JQ_SETUP
	JQ_SETUP=$(echo "$JQ_SETUP" | tr '[:upper:]' '[:lower:]')
	if [ "$JQ_SETUP" != "y" ] && [ "$JQ_SETUP" != "" ]; then exit 1; fi
	echo "Installing..."
	pacman -Syu --noconfirm >/dev/null
	pacman -S jq --needed --noconfirm >/dev/null
fi

pacman_install() {
	clear

	# Root privileges test.
	if [ "$(id -u)" != 0 ]; then
		echo "${RED}To install packages from Pacman you must execute this script with sudo privileges${RESET}"
		exit 1
	fi

	pacman -Syu --noconfirm
	jq -r '.pacman[]' software_list.json | pacman -S - --needed --noconfirm
}

aur_install() {
	clear

	# Root privileges test.
	if [ "$(id -u)" = 0 ]; then
		echo "${RED}Please do not install packages from AUR using root${RESET}"
		exit 1
	fi

	# If yay is not present, install it
	if [ ! "$(command -v yay)" ]; then
		git clone https://aur.archlinux.org/yay.git
		cd yay && makepkg -si --noconfirm && cd - && rm -rf yay
	fi

	jq -r '.aur[]' software_list.json | yay -S - --needed
}

dotfiles_install() {
	clear

	echo "${BOLD}Creating${RESET} ~/.config"
	mkdir -p ~/.config
	echo "${BOLD}Cloning repository${RESET} https://github.com/ludwiklejzer/.dotfiles.git"
	git clone https://github.com/ludwiklejzer/.dotfiles.git ~/dotfiles
	echo "${BOLD}Creating symlinks${RESET}"
	cd ~/dotfiles && stow -vt ~ main-config && cd -
}

confirm_installation() {
	clear
	printf "%s|%s %s %s\n\n" "$BOLD$GREEN" "$RESET$BOLD" "$1" "$RESET"
	jq -r ".$1[]" software_list.json | sort | column
	printf "\nDo you really want to install? %s[Y/n] %s" "$BOLD" "$RESET"
	read -r KEY
	KEY=$(echo "$KEY" | tr '[:upper:]' '[:lower:]')
	if [ "$KEY" != "y" ] && [ "$KEY" != "" ]; then exit 1; fi
}

choose_install() {
	case $NUMBER_SELECTED in
	1)
		confirm_installation pacman
		pacman_install
		;;
	2)
		confirm_installation aur
		aur_install
		;;
	3)
		confirm_installation dotfiles
		dotfiles_install
		;;
	*)
		echo "Invalid Value"
		sleep 2
		display_options
		;;
	esac

	printf "\n%sDone!%s\n" "$BOLD$GREEN" "$RESET"
	exit 0
}

display_options() {
	clear
	cat <<EOL
${BOLD}Select a ${GREEN}NUMBER${RESET} ${BOLD}to proceed the installation${RESET}

${BOLD}${GREEN}|${RESET} ${BOLD}1 - PACMAN${RESET}
${BOLD}${GREEN}|${RESET} ${BOLD}2 - AUR${RESET}
${BOLD}${GREEN}|${RESET} ${BOLD}4 - DOTFILES${RESET}

EOL

	printf "%s>%s " "$BOLD$GREEN" "$RESET"
	read -r NUMBER_SELECTED

	choose_install
}

display_options
