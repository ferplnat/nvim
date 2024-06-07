local M = {}

M.apply = function(harpoon)
    -- basic telescope configuration
    local conf = require("telescope.config").values

    local toggle_telescope = function(harpoon_files)
        local finder = function()
            local paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(paths, item.value)
            end

            return require("telescope.finders").new_table({
                results = paths,
            })
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = finder(),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
                map("i", "<C-d>", function()
                    local state = require("telescope.actions.state")
                    local selected_entry = state.get_selected_entry()
                    local current_picker = state.get_current_picker(prompt_bufnr)

                    table.remove(harpoon_files.items, selected_entry.index)
                    current_picker:refresh(finder())
                end)
                return true
            end,
        }):find()
    end

    local function file_added()
        local message = string.format("Harpoon'd \"%s\"", vim.fn.expand('%'))
        vim.api.nvim_notify(message, vim.log.levels.INFO, { title = "Harpoon" })

        harpoon:list():add()
    end

    vim.keymap.set("n", "<C-h>", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" })

    vim.keymap.set("n", "<C-b>", file_added, { desc = "[m]ark current file in harpoon" })

    vim.keymap.set("n", "<C-j>", function() harpoon:list():prev() end,
        { desc = "Previous item (harpoon)" })

    vim.keymap.set("n", "<C-k>", function() harpoon:list():next() end,
        { desc = "Next item (harpoon)" })
end

return M
