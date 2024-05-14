local M = {}

M.apply = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

M.oil_buf_maps = function(event)
    vim.api.nvim_buf_set_keymap(event.buf, "n", "cd", "", {
        callback = function()
            local message = string.format("cwd is now \"%s\"", vim.fn.expand('%'))
            vim.api.nvim_notify(message, vim.log.levels.INFO, { title = "Oil" })
            require('oil.actions').tcd.callback()
        end,
        desc = "Change cwd to current location"
    })
end

M.oil_keymaps = {
    ["<C-p>"] = false, -- Don't conflict with Telescope
    ["<C-h>"] = false, -- Don't conflict with Harpoon
}

return M
