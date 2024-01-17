--- @type LazyPluginSpec
return {
    name = 'fugitive',
    [1] = 'tpope/vim-fugitive',

    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open ':Git' command line" })
    end,
}
