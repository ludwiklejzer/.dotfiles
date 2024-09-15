export ZSH="$ZDOTDIR/oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git npm bgnotify z colored-man-pages yarn npm vi-mode asdf)
COMPLETION_WAITING_DOTS="true"

# more zsh completions (https://github.com/zsh-users/zsh-completions)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -U compinit && compinit # zsh-completions
source $ZSH/oh-my-zsh.sh

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		 [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
			 [[ ${KEYMAP} == viins ]] ||
			 [[ ${KEYMAP} = '' ]] ||
			 [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

# After each command add a new line and use beam shape cursor
precmd() {
	precmd() {
		echo 
		echo -ne '\e[5 q'
	}
}

# export MANPATH="/usr/local/man:$MANPATH"

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin

# Aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ls='exa --icons --no-quotes'
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
alias calculator='bc'
alias calc='bc'
alias feh='feh --scale-down'
alias wallpaper='\ls ~/Pictures/wallpapers | fzf --no-info --no-scrollbar --preview="feh --bg-fill ~/Pictures/wallpapers/{}" | xargs -I {} feh --bg-fill ~/Pictures/wallpapers/{}'
alias screensaver='cmatrix -M "Hello, friend" -C red -s -u 7 -k'
alias screencast="ffmpeg -f x11grab -s $(xrandr | grep '*' | awk '{ print $1 }') -i :0.0 -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -f matroska - | castnow --quiet - --type video/mp4"
alias ytdl='youtube-dl'
alias myip='echo "\n\033[91mLocal IP\033[0m" && ip -br -c a && echo "\n\033[91mPublic IP\033[0m" && curl https://ip.me/'
alias wmclass="xprop | grep WM_CLASS"
alias wmsize="xdotool selectwindow getwindowgeometry"
alias rec_audio="ffmpeg -f pulse -i default $(date +%Y-%m-%d_%H:%M).mp3"
alias pegasus="~/Workbench/pegasus-development/pegasus-fe --portable --disable-menu-reboot --disable-menu-shutdown --disable-menu-suspend"

# Descobrir como resolver o stuttering
alias screenrecorder="ffmpeg -f x11grab -s 1366x768 -i :0.0+0,0 -f pulse -i 0 -filter:a "volume=5.0" out.mkv"

qemu_nogrc() {
	qemu-system-x86_64 \
		-nographic \
		-serial mon:stdio \
		--enable-kvm \
		-smp 2 \
		-m 1.5G \
		-boot d \
		-hda $1 \
		-nic user,hostfwd=tcp:127.0.0.1:2222-:22
}

qemu_grc() {
	qemu-system-x86_64 \
		--enable-kvm \
		-smp 2 \
		-m 1.5G \
		-boot d \
		-hda $1 \
		-vga virtio \
		-nic user,hostfwd=tcp:127.0.0.1:2222-:22
}

# zoxide
eval "$(zoxide init zsh)"

# z jump around
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# ASDF
. /opt/asdf-vm/asdf.sh

# Use ripgrep in FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50%'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
