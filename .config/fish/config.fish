# Do nothing if the session is not interactive.
if not status is-interactive
    return
end

# Remove the welcome message.
set -g fish_greeting

# Use vi(m) key bindings.
function fish_user_key_bindings
    fish_vi_key_bindings

    bind --mode insert \ar history-pager
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# Add to path.
# NOTE: delete this section if working on remote server
fish_add_path /Users/rok/.local/bin
# homebrew
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
# python
source ~/.pyg/bin/activate.fish
# rust, cargo
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path /Users/rok/.cargo/bin
# java
fish_add_path /opt/homebrew/opt/openjdk@17/bin
# latex
fish_add_path /Library/TeX/texbin
# llvm, clangd
fish_add_path /opt/homebrew/opt/llvm/bin
# other
fish_add_path /Applications/quarto/bin
# Microsoft SQL ODBC Driver
set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/msodbcsql18/18.4.1.1/lib:$DYLD_LIBRARY_PATH
set -gx ODBCINI /opt/homebrew/etc/odbcinst.ini
set -gx ODBCSYSINI /opt/homebrew/etc
# relink some binaries
if test -x /opt/homebrew/bin/pinentry-mac
    alias pinentry /opt/homebrew/bin/pinentry-mac
end
if test -x /opt/homebrew/bin/rsync
    alias rsync /opt/homebrew/bin/rsync
end

# abbreviations and aliases
alias ls "eza -la --git --hyperlink --group-directories-first" # nice output with <A-l>

source ~/.config/fish/abbr_git.fish
source ~/.config/fish/abbr_docker.fish

abbr --add py python
alias ipy "ipython --no-confirm-exit --no-banner --TerminalInteractiveShell.editing_mode=vi"
abbr --add se "source .venv/bin/activate.fish"

abbr --add llama 'llama-swap -config ~/.llama-swap.yaml'
abbr --add oc "opencode"

# kill on qwerty is euii on colemak
# for the others to be able to use the computer if I am not there
alias kbd "launchctl start com.rok.kanata"
alias euii "kill (launchctl list | grep com.rok.kanata | awk '{print $1}')"

# compliments of fish docs
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# Initialize tools, if they are available
if type -q fzf
    fzf --fish | source
    set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always {}'"
    set -gx FZF_ALT_C_OPTS "--preview 'eza -la --git --color=always {}'"
end
if type -q zoxide
    zoxide init fish --cmd cd | source
end
if type -q direnv
    direnv hook fish | source
end

set -gx GPG_TTY (tty)
gpg-agent --daemon &>/dev/null

# claude code
export ANTHROPIC_BASE_URL="http://localhost:4141"
export ANTHROPIC_API_KEY="copilot-api"
export ANTHROPIC_MODEL="claude-opus-4.5"
