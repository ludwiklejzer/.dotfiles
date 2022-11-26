PROMPT="%(?:%{$fg_bold[green]%}› :%{$fg_bold[red]%}› )%{$reset_color%}"
RPROMPT='%{$fg[cyan]%}%c%{$reset_color%}$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} / %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
