--- @type LazyPluginSpec
return {
    name = 'toggleterm',
    [1] = 'akinsho/toggleterm.nvim',
    version = "*",

    config = function()
        require('toggleterm').setup({
            open_mapping = '<C-\\>',
            insert_mappings = false,
            hide_numbers = false,
            direction = 'horizontal',
            size = 30,
            shade_terminals = false,

            highlights = {
                Normal = {
                    link = 'ToggleTermNormal',
                },

                StatusLine = {
                    link = 'ToggleTermStatusLine',
                },
            },

            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-n>", "<cmd>stopinsert!<Return>",
                    { noremap = true, silent = true })
            end,
        })
    end,
}
