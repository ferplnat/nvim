local group = vim.api.nvim_create_augroup("marco_lazy", {})

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "LazyDone",
    group = group,
    callback = function()
--        require('marco.scratchpad')
    end,
})
