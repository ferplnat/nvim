vim.opt.statusline = '%!v:lua.require("marco.statusline").render()'

local opts = {}
local active_client_names = function()
    local client_names = {}
    local active_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, c in pairs(active_clients) do
       client_names[#client_names + 1] = c.name
    end

    if #client_names == 0 then
        return "no active lsp"
    end

    return string.format("active lsp: %s (%s)", table.concat(client_names, ', '), vim.bo.filetype)
end

function opts.render()
    local statusline = {
        "%<%f %h%m%r%{FugitiveStatusline()}",
        " | "..active_client_names(),
        "%=",
        "%-14.(%l,%c%V%) %P ",
    }

    return table.concat(statusline, '')
end

return opts
