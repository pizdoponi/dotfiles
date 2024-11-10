# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# enable pub commands to be global
# export PATH="$PATH":"$HOME/.pub-cache/bin"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Case-insensitive completion
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search zsh-vi-mode zsh-lazyload dotenv you-should-use dirhistory eza)

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# ╭──────────────────────────────────────────────────────────╮
# │                    User configuration                    │
# ╰──────────────────────────────────────────────────────────╯

# export MANPATH="/usr/local/man:$MANPATH"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ╭──────────────────────────────────────────────────────────╮
# │                         exports                          │
# ╰──────────────────────────────────────────────────────────╯
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/rok/.cargo/bin:$PATH" # cargo
export PATH="/usr/local/smlnj/bin:$PATH" # sml
# ODBC driver (microsft sql server driver)
export DYLD_LIBRARY_PATH=/opt/homebrew/Cellar/msodbcsql18/18.4.1.1/lib:$DYLD_LIBRARY_PATH
export ODBCINI=/opt/homebrew/etc/odbcinst.ini
export ODBCSYSINI=/opt/homebrew/etc

# ╭──────────────────────────────────────────────────────────╮
# │                         aliases                          │
# ╰──────────────────────────────────────────────────────────╯
# I use neovim, btw
alias vi="nvim"
alias vimdiff="nvim -d"
# ls
alias l="eza"
alias ll="l -lah"
# services
alias chat="source ~/packages/open-webui/backend/.venv/bin/activate && bash ~/packages/open-webui/backend/start.sh"
alias kbd="cd ~/packages/kanata && sudo ./kanata_macos_arm64 --cfg main.kbd"
# other
# alias bsmods="cd /Users/rok/Library/Containers/net.froemling.bombsquad/Data/Library/Application\ Support/BombSquad/mods";
alias pinentry="pinentry-mac"

# copy the current directory path or file contents to the clipboard
function y() {
  if [ -z "$1" ]; then
    # No argument provided, copy the current directory path
    pwd | pbcopy
  else
    # Argument provided, copy the contents of the specified file
    cat "$1" | pbcopy
  fi
}

# ╭──────────────────────────────────────────────────────────╮
# │                         plugins                          │
# ╰──────────────────────────────────────────────────────────╯
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate
conda activate main

# nvm
export NVM_DIR="$HOME/.nvm"
  # [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  # [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# lazyload nvm
lazyload nvm node npm npx yarn pnpm -- '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"; [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"'

# programs
eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval ${gpg-agent --daemon >& /dev/null}
export GPG_TTY=$TTY
eval $(thefuck --alias)
alias rsync="/opt/homebrew/bin/rsync"

# yazi
function e() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# broot
function br {
    local cmd cmd_file code
    cmd_file=$(mktemp)
    if broot --outcmd "$cmd_file" "$@"; then
        cmd=$(<"$cmd_file")
        command rm -f "$cmd_file"
        eval "$cmd"
    else
        code=$?
        command rm -f "$cmd_file"
        return "$code"
    fi
}

# ──────────────────────────────────────────────────────────────────────
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof
