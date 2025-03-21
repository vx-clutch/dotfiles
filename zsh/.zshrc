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
alias gg='lazygit'

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

export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:/~/go/bin/
export PATH=$PATH:/mnt/c/ProgramData/chocolatey/lib/mpvio.install/tools/mpv.exe
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$JAVA_HOME/bin:$PATH

export TERM="xterm-256color"
export COLORTERM=truecolor

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

function take() {
  mkdir $1 && cd $1
}
function retake() {
  rm -rf $1 && mkdir $1 && cd $1
}

function clip() {
  cat $1 | clip.exe
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

if [ "$TMUX" = "" ]; then tmux; fi
