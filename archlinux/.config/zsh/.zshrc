export ZSH="/home/ludwiklejzer/.oh-my-zsh"
ZSH_THEME="mytheme"

plugins=(git npm bgnotify z colored-man-pages yarn npm adb vi-mode asdf)

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

# pywal
(cat ~/.cache/wal/sequences &)
# pywall - tty support
source ~/.cache/wal/colors-tty.sh

# export MANPATH="/usr/local/man:$MANPATH"

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin

# Aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias ls='exa --icons'
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
alias calculator='bc'
alias calc='bc'
alias feh='feh --scale-down --no-fehbg'
alias ytdl='youtube-dl'
alias myip='echo "\n\033[91mLocal IP\033[0m" && ip -br -c a && echo "\n\033[91mPublic IP\033[0m" && curl https://ip.me/'
alias note="cd ~/Sync/wiki && vim -c ':VimwikiIndex'"
alias notes="cd ~/Sync/wiki && vim -c ':Files'"
alias wmclass="xprop | grep WM_CLASS"

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

# z jump around
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# ASDF
. /opt/asdf-vm/asdf.sh

# Use ripgrep in FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50%'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
