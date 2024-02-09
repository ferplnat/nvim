local M = {}

M.telescope_attach_mappings = function(harpoon)
    return function(_, map)
        map("i", "<C-d>", function(picker_bufnr)
            local picker = require("telescope.actions.state").get_current_picker(picker_bufnr)

            picker:delete_selection(function(selection)
                harpoon:list():removeAt(selection.index)
            end)
        end)
        return true
    end
end

M.apply = function(harpoon)
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local toggle_telescope = function(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
            attach_mappings = M.telescope_attach_mappings(harpoon),
        }):find()
    end

    local function file_added()
        local message = string.format("Harpoon'd \"%s\"", vim.fn.expand('%'))
        vim.api.nvim_echo({ { message, nil } }, false, {})

        harpoon:list():append()
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
