return {
    'stevearc/oil.nvim',

    config = function()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        local group = vim.api.nvim_create_augroup("marco_oil", {})
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
        })
    end,
}
