function pyini
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
