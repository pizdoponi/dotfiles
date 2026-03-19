local M = {}

M.apply_to_config = function(config)
	config.disable_default_key_bindings = false
	config.quick_select_patterns = {
		-- base file names
		"[a-zA-Z][a-zA-Z0-9_.-]*\\.(?:c|cpp|py|lua|json|csv|ts|js|html|css|scss|md|sh|java|rs|go|zip|tar|pdf|xlsx|docx|pptx|txt|yml|yaml|toml|log|xml|sql|rb|php|dart)",
		-- dot files ... many false positives
		-- "\\.[a-zA-Z0-9_.-]*",
		-- anything inside quotes
		'"[^"]+"',
		"'[^']+'",
		-- branch names, e.g. 42-bug-fix
		"\\d+[a-zA-Z-_]+",
		-- snake_case_variables
		"[a-zA-Z]+_[a-zA-Z0-9_]+"
	}
	config.quick_select_alphabet = "arstqwfpzxcvneioluymdhgjbk" -- colemak
end

return M
