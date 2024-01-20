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
        lspMessage = string.format("lsp: %s", table.concat(client_names, ', '))
    end

    if vim.bo.filetype ~= "" then
        lspMessage = string.format("%s (%s)", lspMessage, vim.bo.filetype)
    end

    if copilotActive then
        lspMessage = lspMessage .. " {copilot}"
    end

    return lspMessage
end

local current_mode = function()
    local mode = vim.fn.mode()
    local mode_map = {
        ['n'] = 'NORMAL',
        ['no'] = 'NORMAL',
        ['nov'] = 'NORMAL',
        ['noV'] = 'NORMAL',
        ['no'] = 'NORMAL',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        [''] = 'VISUAL BLOCK',
        ['s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        [''] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rv'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rvc'] = 'REPLACE',
        ['Rvx'] = 'REPLACE',
        ['c'] = 'COMMAND',
        ['cr'] = 'COMMAND',
        ['cv'] = 'COMMAND',
        ['cvr'] = 'COMMAND',
        ['r'] = 'HIT ENTER',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
        ['null'] = 'NONE',
    }

    local rendered_mode = "[" .. mode .. "]"

    if mode_map[mode] ~= nil then
        rendered_mode = rendered_mode .. "[" .. mode_map[mode] .. "]"
    end

    return " --" .. rendered_mode .. "-- "
end

function opts.render()
    -- Get the width that the statusline will be rendered at
    local status_width = vim.api.nvim_eval_statusline('%=%=', {}).width

    -- Get the rendered strings for the left, center, and right side of the statusline
    local left_side = vim.api.nvim_eval_statusline("%f %h%m%r%{FugitiveStatusline()} | " .. active_client_names(), {})
        .str

    local center = current_mode()
    local recording = vim.fn.reg_recording()
    if recording ~= '' then
        center = center .. ' rec: @' .. recording
    end

    local right_side = vim.api.nvim_eval_statusline("%l,%c%V ", {}).str

    -- Get the width of the rendered strings
    local left_side_width = vim.fn.strdisplaywidth(left_side)
    local right_side_width = vim.fn.strdisplaywidth(right_side)
    local center_width = vim.fn.strdisplaywidth(center)

    -- Calculate the padding needed to align the rendered strings
    local left_side_padding = math.floor((status_width - center_width) / 2) - left_side_width
    local right_side_padding = math.ceil((status_width - center_width) / 2) - right_side_width

    -- Create the padding strings
    local left_padding = string.rep(' ', left_side_padding)
    local right_padding = string.rep(' ', right_side_padding)

    -- KA-CHOW!
    return left_side .. left_padding .. center .. right_padding .. right_side
end

return opts
