bindkey -e

# Set the default editor to Neovim
export EDITOR=nvim
export SUDO_EDITOR=nvim
export VISUAL=nvim

# Set PROVIDER for ai-commit
export PROVIDER=ollama

# Alias definitions
alias ls='ls --color=auto'
alias ll='ls -lah'
alias ff='fastfetch'
alias apt='nala'
alias gg='lazygit'
alias signout='loginctl terminate-user $USER'
alias vim='nvim'

# Check if color is supported for ls, set alias accordingly
if ls --color=auto &>/dev/null; then
  alias ls='ls -p --color=auto'
else
  alias ls='ls -p -G'
fi

# Highlight search results with ripgrep
alias hl='rg --passthru'
alias gerp='rg'

# Functions
take() {
  mkdir $1 && cd $1
}

clip() { # wsl only
  cat $1 | clip.exe
}

# Source custom Zap configuration if available
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugin manager configuration
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/sudo"
plug "Aloxaf/fzf-tab"
bindkey "^R" history-incremental-search-backward

# Initialize autocomplete
autoload -Uz compinit
compinit

# Starship prompt initialization
eval "$(starship init zsh)"

# Terminal settings
export TERM="xterm-256color"
export COLORTERM=truecolor

# Linuxbrew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Tmux startup if not already in tmux
if [ "$TMUX" = "" ]; then tmux; fi


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/owen/.opam/opam-init/init.zsh' ]] || source '/home/owen/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
