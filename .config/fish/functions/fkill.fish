# Kill processes using fzf
function fkill
    ps aux | fzf --multi | awk '{print $2}' | xargs --no-run-if-empty kill
end
