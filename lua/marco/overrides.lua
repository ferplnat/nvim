-- This file contains overrides for built-in functions and variables.

---@diagnostic disable-next-line: duplicate-set-field
vim.api.nvim_notify = function(message, log_level, opts)
    opts = opts or {}
    log_level = log_level or vim.log.levels.INFO

    if opts.title then
        message = '[' .. opts.title .. '] ' .. message
    end

    vim.notify(message, log_level, opts)
end
