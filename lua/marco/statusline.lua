vim.opt.statusline = '%!v:lua.require("marco.statusline").render()'

local opts = {}
local active_client_names = function()
    local client_names = {}
    local active_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    local copilotActive = false

    for _, c in pairs(active_clients) do
        if c.name == 'copilot' then
            copilotActive = true
        else
            client_names[#client_names + 1] = c.name
        end
    end

    local lspMessage
    if #client_names == 0 then
        lspMessage = "no active lsp"
    else
        lspMessage = string.format("lsp: %s (%s)", table.concat(client_names, ', '), vim.bo.filetype)
    end

    if copilotActive then
        lspMessage = lspMessage .. " [copilot]"
    end

    return lspMessage
end

function opts.render()
    local statusline = {
        "%<%f %h%m%r%{FugitiveStatusline()}",
        " | " .. active_client_names(),
        "%=",
        "%-14.(%l,%c%V%) %P ",
    }

    return table.concat(statusline, '')
end

return opts
