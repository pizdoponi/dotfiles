# Commands to run in interactive sessions can go here
if status is-interactive
    # ╭──────────────────────────────────────────────────────────╮
    # │                         Paths                            │
    # ╰──────────────────────────────────────────────────────────╯
    set -U fish_user_paths /opt/homebrew/bin /opt/homebrew/sbin $fish_user_paths

    #if test -x /usr/local/anaconda3/bin/conda
    #    set -gx PATH /usr/local/anaconda3/bin $PATH
    #    function conda
    #        eval (command /usr/local/anaconda3/bin/conda "shell.fish" "hook" $argv)
    #    end
    #end


    set -gx PATH /Users/rok/.cargo/bin $PATH
    set -gx PATH /usr/local/smlnj/bin $PATH

    # Microsoft SQL ODBC Driver
    set -gx DYLD_LIBRARY_PATH /opt/homebrew/Cellar/msodbcsql18/18.4.1.1/lib:$DYLD_LIBRARY_PATH
    set -gx ODBCINI /opt/homebrew/etc/odbcinst.ini
    set -gx ODBCSYSINI /opt/homebrew/etc

    # ╭──────────────────────────────────────────────────────────╮
    # │                         Editor                           │
    # ╰──────────────────────────────────────────────────────────╯
    if test -n "$SSH_CONNECTION"
        set -gx EDITOR vim
        set -gx VISUAL vim
    else
        set -gx EDITOR nvim
        set -gx VISUAL nvim
    end

    # ╭──────────────────────────────────────────────────────────╮
    # │                        Aliases                           │
    # ╰──────────────────────────────────────────────────────────╯
    # I use neovim, btw
    alias vi nvim
    alias vimdiff "nvim -d"
    alias ls eza
    alias ipy ipython
    alias ll "eza -lah --icons --color=always --group-directories-first"
    alias chat "source ~/packages/open-webui/backend/.venv/bin/activate; bash ~/packages/open-webui/backend/start.sh"
    alias kbd "cd ~/.config/kanata; sudo ./kanata_macos_arm64 --cfg main.kbd"
    alias tre "eza --tree --color=always --icons"

    if test -x /opt/homebrew/bin/pinentry-mac
        alias pinentry /opt/homebrew/bin/pinentry-mac
    end
    if test -x /opt/homebrew/bin/rsync
        alias rsync /opt/homebrew/bin/rsync
    end

    # ╭──────────────────────────────────────────────────────────╮
    # │                     Functions                            │
    # ╰──────────────────────────────────────────────────────────╯
    # Copy the current directory path or file contents to clipboard
    function y
        if test -z "$argv[1]"
            pwd | pbcopy
        else
            cat $argv[1] | pbcopy
        end
    end

    # Kill processes using fzf
    function fkill
        ps aux | fzf --multi | awk '{print $2}' | xargs kill
    end

    function init
        # if there is a .env file, source it
        # the variables are assumed to be in the format VAR=value
        if test -f .env
            # ignore comments and empty lines
            for line in (grep -v '^#' .env | sed '/^\s*$/d')
                # split the line by the first '='
                set key_value (string split "=" $line)
                set -gx $key_value[1] $key_value[2]
            end
        end
        # if there is a .venv directory, activate it
        if test -d .venv
            source .venv/bin/activate.fish
        end
        # add pwd to PYTHONPATH
        set -gx PYTHONPATH $PYTHONPATH (pwd)
    end

    # ╭──────────────────────────────────────────────────────────╮
    # │                      Initialization                      │
    # ╰──────────────────────────────────────────────────────────╯
    zoxide init fish --cmd cd | source
    fzf --fish | source

    set -gx GPG_TTY (tty)
    gpg-agent --daemon &>/dev/null

    pyenv init - | source

    # ╭──────────────────────────────────────────────────────────╮
    # │                     Customization                        │
    # ╰──────────────────────────────────────────────────────────╯
    function fish_user_key_bindings
        fish_vi_key_bindings

        bind --mode insert \cr history-pager
        bind --mode insert \cs pager-toggle-search
    end

end
