--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'oil',
    [1] = 'stevearc/oil.nvim',

    config = function()
        local remaps = require('marco.remaps.oil')
        remaps.apply()

        local group = vim.api.nvim_create_augroup("marco_oil", {})

        -- oil fix relative path
        -- this also makes sure any files marked with Harpoon are properly
        -- opened/rendered in the list.
        vim.api.nvim_create_augroup('OilRelPathFix', {})
        vim.api.nvim_create_autocmd("BufLeave", {
            group    = 'OilRelPathFix',
            pattern  = "oil:///*",
            callback = function()
                vim.cmd("tcd .")
            end,
        })

        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = group,
            pattern = "oil",
            callback = remaps.oil_buf_maps,
        })

        local hide_prefixes = { "__" }

        require('oil').setup({
            default_file_explorer = true,
            keymaps = remaps.oil_keymaps,
            view_options = {
                show_hidden = false,
                is_hidden_file = function(name)
                    local hide = false

                    for _, prefix in ipairs(hide_prefixes) do
                        if vim.startswith(name, prefix) then
                            hide = true
                            break
                        end
                    end

                    return hide
                end,
                is_always_hidden = function(name)
                    return vim.startswith(name, "..")
                end,
            },
        })
    end,
}
