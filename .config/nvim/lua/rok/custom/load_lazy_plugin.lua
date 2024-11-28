local lazy = require("lazy")

-- Function to load only unloaded lazy-loaded plugins
function LoadLazyPlugin()
    -- Get all plugins managed by lazy that are not yet loaded
    local unloaded_plugins = {}
    for _, plugin in pairs(lazy.plugins()) do
        if plugin.lazy and not plugin._.loaded then
            table.insert(unloaded_plugins, plugin.name)
        end
    end

    -- Use Telescope to pick an unloaded plugin
    require("telescope.pickers")
        .new({}, {
            prompt_title = "Load Lazy Plugin",
            finder = require("telescope.finders").new_table({
                results = unloaded_plugins,
            }),
            sorter = require("telescope.config").values.generic_sorter({}),
            attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                    local selection = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").close(prompt_bufnr)
                    lazy.load({ plugins = { selection[1] } })
                    print("Loaded plugin: " .. selection[1])
                end)
                return true
            end,
        })
        :find()
end

vim.api.nvim_create_user_command("LoadLazyPlugin", LoadLazyPlugin, {})
