export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim
alias ls='ls --color=auto'
alias ll='ls -lah'
alias ff='fastfetch'

if ! command -v zap &>/dev/null; then
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi

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
