function __ollama_models
    ollama ls | awk 'NR > 1 {print $1}'
end


complete --command ollama --arguments "run stop list ls ps rm" --description "ollama command" --no-files --condition "__fish_is_first_arg"
complete --command ollama --arguments "(__ollama_models)" --condition "__fish_seen_subcommand_from run stop rm" --description "model" --no-files