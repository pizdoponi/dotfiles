# Commands to run in interactive sessions can go here
if status is-interactive

    function fish_user_key_bindings
        fish_vi_key_bindings

        bind --mode insert \ar history-pager
    end

    set -gx EDITOR vim
    set -gx VISUAL vim
    set -gx PAGER less

    # homebrew
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
    # python
    source ~/.pyg/bin/activate.fish
    # rust, cargo
    fish_add_path /opt/homebrew/opt/rustup/bin
    fish_add_path /Users/rok/.cargo/bin
    # lm studio
    fish_add_path /Users/rok/.cache/lm-studio/bin
    # Microsoft SQL ODBC Driver
    set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/msodbcsql18/18.4.1.1/lib:$DYLD_LIBRARY_PATH
    set -gx ODBCINI /opt/homebrew/etc/odbcinst.ini
    set -gx ODBCSYSINI /opt/homebrew/etc

    if test -x /opt/homebrew/bin/pinentry-mac
        alias pinentry /opt/homebrew/bin/pinentry-mac
    end
    if test -x /opt/homebrew/bin/rsync
        alias rsync /opt/homebrew/bin/rsync
    end

    # abbreviations and aliases
    alias ls "eza -la --git --hyperlink --group-directories-first"

    source ~/.config/fish/git_abbr.fish

    abbr --add py python
    alias ipy "ipython --no-confirm-exit --no-banner --TerminalInteractiveShell.editing_mode=vi"

    abbr --add md2pdf "pandoc --pdf-engine=xelatex --template=eisvogel"
    alias chat "source ~/packages/open-webui/backend/.venv/bin/activate; bash ~/packages/open-webui/backend/start.sh"
    alias kbd "cd ~/.config/kanata; sudo ./kanata_macos_arm64 --cfg main.kbd"

    # compliments of fish docs
    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    # Initialize tools, if they are available
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end
    if type -q fzf
        fzf --fish | source
    end

    set -gx GPG_TTY (tty)
    gpg-agent --daemon &>/dev/null

    # remove the welcome message
    set -g fish_greeting
end
