export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim
alias ls='ls --color=auto'
alias ll='ls -lah'
alias ff='fastfetch'
alias apt='nala'
alias b='bat --paging=always'
alias t='tldrb'
alias nv='nvim'

function tldrb {
  tldr $1 | b
}

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/sudo"
plug "zsh-users/zsh-history-substring-search"
plug "Aloxaf/fzf-tab"

autoload -Uz compinit
compinit

eval "$(starship init zsh)"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:/~/go/bin/
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
