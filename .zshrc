# Created by newuser for 5.9.2
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)
source $ZSH/oh-my-zsh.sh

bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey '^H' backward-kill-word

export COLORTERM=truecolor
export EDITOR='nvim'

alias cl=clear
alias cn="cd nvim && nvim init.lua"
alias sup='sudo -E -s'
alias dcps='docker compose ps --all --format "table {{.Name}}\t{{.Service}}\t{{.State}}\t{{.Health}}"'

alias ls=lsd

eval "$(zoxide init zsh --cmd cd)"

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
