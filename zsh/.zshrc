bindkey -e

export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim
export TERM="xterm-256color"
export COLORTERM=truecolor

export PATH=$HOME/.scripts:$PATH

alias ls='ls --color=auto'
alias ll='ls -lah'
alias gg='lazygit'
alias v='nvim'

take() {
  mkdir $1;
  cd $1
}

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/sudo"
plug "Aloxaf/fzf-tab"

autoload -Uz compinit
compinit

eval "$(starship init zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if [ "$TMUX" = "" ]; then tmux; fi
