--- @type LazyPluginSpec
return {
    name = 'oil',
    [1] = 'stevearc/oil.nvim',

    config = function()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        local group = vim.api.nvim_create_augroup("marco_oil", {})

        -- oil fix relative path
        -- this also makes sure any files marked with Harpoon are properly
        -- opened/rendered in the list.
        vim.api.nvim_create_augroup('OilRelPathFix', {})
        vim.api.nvim_create_autocmd("BufLeave", {
            group    = 'OilRelPathFix',
            pattern  = "oil:///*",
            callback = function()
                vim.cmd("cd .")
            end,
        })

        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = group,
            pattern = "oil",
            callback = function(ev)
                vim.api.nvim_buf_set_keymap(ev.buf, "n", "cd", "", {
                    callback = function()
                        local message = string.format("cwd is now \"%s\"", vim.fn.expand('%'))
                        vim.api.nvim_echo({ { message, nil } }, false, {})
                        require('oil.actions').cd.callback()
                    end,
                    desc = "Change cwd to current location"
                })
            end,
        })

        require('oil').setup({
            default_file_explorer = true,
            keymaps = {
                ["<C-p>"] = false, -- Don't conflict with Telescope
                ["<C-h>"] = false, -- Don't conflict with Harpoon
            }
        })
    end,
}
