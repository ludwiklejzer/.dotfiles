export ZSH="$ZDOTDIR/oh-my-zsh"

ZSH_THEME="half-life"
plugins=(git npm z colored-man-pages npm vi-mode asdf web-search fzf themes)
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
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Aliases
alias goto='target_dir=$(=fd -H --max-depth=4 -t d . $HOME | fzf --height 50% --border --no-scrollbar --no-info --preview "eza --tree --icons --level=1 {}" --preview-window=top:50%:border-line) && cd $target_dir'
alias vim=nvim
alias vi=nvim
alias v=nvim
alias ls='eza -h --icons --no-quotes --git --group --group-directories-first --time-style=long-iso'
alias tree='eza --tree --icons --no-quotes --git --group --group-directories-first --time-style=long-iso'
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
alias calculator='bc'
alias calc='bc'
alias feh='feh --scale-down'
alias wallpaper='\ls ~/Pictures/wallpapers | fzf --no-info --no-scrollbar --preview="feh --bg-fill ~/Pictures/wallpapers/{}" | xargs -I {} feh --bg-fill ~/Pictures/wallpapers/{}'
alias screensaver='hyprctl dispatch fullscreen && neo -s -m "Hello, friend."'
#alias screencast="ffmpeg -f x11grab -s $(xrandr | grep '*' | awk '{ print $1 }') -i :0.0 -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -f matroska - | castnow --quiet - --type video/mp4"
alias webcam="mpv --no-resume-playback --profile=low-latency --untimed --demuxer-lavf-o=video_size=640x480 /dev/video0"
alias ytdl='youtube-dl'
alias myip='echo "\n\033[91mLocal IP\033[0m" && ip -br -c a && echo "\n\033[91mPublic IP\033[0m" && curl https://ip.me/'
alias wmclass="xprop | grep WM_CLASS"
alias wmsize="xdotool selectwindow getwindowgeometry"
alias rec_audio="ffmpeg -y -f pulse -i default $(date +%Y-%m-%d_%H:%M).mp3"
alias pegasus="~/Workbench/pegasus-development/pegasus-fe --portable --disable-menu-reboot --disable-menu-shutdown --disable-menu-suspend"
alias music="ncmpcpp"
alias lyrics="sptlrx --before "faint""
alias poweroff='notify-send -t 5000 "Mouse" "Remember to Turn Off your Mouse"  -h int:x-hyprnotify-font-size:20 -h int:x-hyprnotify-icon:0; sleep 5 && shutdown -P 0'
alias screenrecorder="ffmpeg -f x11grab -s 1366x768 -i :0.0+0,0 -f pulse -i 0 -filter:a "volume=5.0" out.mkv"
alias videos_total_time=get_videos_time_amount

get_videos_time_amount(){
	for f in ./*.mp4; do 
		ffprobe -v quiet -of csv=p=0 -show_entries format=duration "$f";
	done | awk '{sum += $1}; END{print sum/3600 " hours"}'
}


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

set_wall() {
	monitors="$(hyprctl monitors | grep Monitor | awk '{print $2}')"

	if [ ! "$(pgrep -x hyprpaper)" ]; then
		hyprpaper &
		sleep 0.5
	fi

	if [ "$1" ]; then
		image=$(realpath $1)

		hyprctl hyprpaper unload all
		hyprctl hyprpaper preload "$image"

		for monitor in $monitors; do
			hyprctl hyprpaper wallpaper "$monitor, $image"
		done
	fi
}

# Use ripgrep in FZF
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50%'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
