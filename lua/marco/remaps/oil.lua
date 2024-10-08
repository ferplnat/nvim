local M = {}

M.apply = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

M.oil_buf_maps = function(event)
    vim.api.nvim_buf_set_keymap(event.buf, "n", "cd", "", {
        callback = function()
            require('oil.actions').tcd.callback()
        end,
        desc = "Change cwd to current location (tcd)"
    })
end

M.oil_keymaps = {
    ["<C-p>"] = false, -- Don't conflict with Telescope
    ["<C-h>"] = false, -- Don't conflict with Harpoon
}

return M
