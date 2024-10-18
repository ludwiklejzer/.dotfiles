# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# IBUS
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

# QT
export QT_QPA_PLATFORMTHEME=qt6ct
# export QT_STYLE_OVERRIDE=GTK+

# SQLITE
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"

# Z
export _Z_DATA="$XDG_DATA_HOME/z"

# X11
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/.Xauthority"

# ASDF
export ASDF_DIR="/opt/asdf-vm"
export ASDF_DATA_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/asdfrc"

# WGET
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# NODE
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# NPM
export prefix="$XDG_DATA_HOME/npm"
export cache="$XDG_CACHE_HOME/npm"
# export init-module="$XDG_CONFIG_HOME/npm/config/npm-init.js"
#export logs-dir="$XDG_STATE_HOME/npm/logs"

# PYTHON
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

# MYPY
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"

# LESS
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

# RANGER
export RANGER_LOAD_DEFAULT_RC="FALSE"

# W3M
export W3M_DIR="$XDG_STATE_HOME/w3m"

# POSTGRESS
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# MISC
# export LANG="en_US.UTF-8"
export LANG="fr_FR.UTF-8"
export EDITOR="nvim"
export TERMINAL="wezterm"
export BROWSER="qutebrowser"
export LS_COLORS=ow="36;40:"

# MESA
# https://bugs.winehq.org/show_bug.cgi?id=50859
# export MESA_GL_VERSION_OVERRIDE=4.5

# Automatically start Hyprland on tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec Hyprland
fi
