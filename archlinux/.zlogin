# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# FCITX5
export GTK_IM_MODULE=xim
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# QT
export QT_QPA_PLATFORMTHEME=qt6ct
# export QT_STYLE_OVERRIDE=GTK+

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"

# Z
export _Z_DATA="$XDG_DATA_HOME/z"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/.Xauthority"

# ASDF
export ASDF_DIR="/opt/asdf-vm"
export ASDF_DATA_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=".config/asdf/tool-versions"

# WGET
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# NODE
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# NPM
export prefix="$XDG_DATA_HOME/npm"
export cache="$XDG_CACHE_HOME}/npm"
# export init-module="$XDG_CONFIG_HOME/npm/config/npm-init.js"

# LESS
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

# RANGER
export RANGER_LOAD_DEFAULT_RC="FALSE"

# MISC
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export LS_COLORS=ow="36;40:"

# run startx automatically on tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx "$HOME/.config/X11/xinitrc"
fi
