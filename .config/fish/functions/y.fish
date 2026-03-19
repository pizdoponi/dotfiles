# Copy the current directory path or file contents to clipboard
function y
    if test -z "$argv[1]"
        pwd | pbcopy
    else
        echo $argv[1] | pbcopy
    end
end
