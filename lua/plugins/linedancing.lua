--- @type LazyPluginSpec
return {
    name = 'linedancing',
    [1] = 'ferplnat/linedancing.nvim',
    branch = 'more_async',
    config = function()
        require('linedancing').setup({
            components = {
                {
                    name = 'filepath',
                    callback = function()
                        return '%f %h%m%r'
                    end,
                    highlight = '',
                    event = { 'BufEnter', 'BufLeave' },
                    user_event = { 'LazyDone' },
                    position = 'left',
                    eval = true,
                },

                {
                    name = 'fugitive',
                    callback = function()
                        return '%{FugitiveStatusline()}'
                    end,
                    highlight = '',
                    event = { 'BufReadPost', 'BufNewFile' },
                    position = 'left',
                    eval = true,
                },

                {
                    name = 'lsp',
                    callback = function(event)
                        local client_names = {}
                        local active_clients = vim.lsp.get_clients({ bufnr = event.buf or vim.api.nvim_get_current_buf() })
                        local copilot_active = false
                        local null_ls_active = false

                        for _, c in pairs(active_clients) do
                            if c.name == 'copilot' then
                                copilot_active = true
                            elseif c.name == 'null-ls' then
                                null_ls_active = true
                            else
                                client_names[#client_names + 1] = c.name
                            end
                        end

                        if null_ls_active then
                            for _, source in pairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
                                client_names[#client_names + 1] = source.name .. '*n-ls'
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

                        if copilot_active then
                            lspMessage = lspMessage .. " {copilot}"
                        end

                        return " | " .. lspMessage
                    end,

                    highlight = '',
                    event = { 'LspAttach', 'LspDetach', 'LspRequest' },
                    position = 'left',
                    eval = false,
                },

                {
                    name = 'mode',
                    callback = function(event)
                        local mode
                        if event.event == "VimEnter" then
                            mode = 'n'
                        else
                            mode = vim.fn.split(event.match, ':')[2] or 'null'
                        end
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
                            ['V'] = 'VISUAL LINE',
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
                    end,
                    highlight = 'StatusLineMode',
                    event = { 'ModeChanged' },
                    position = 'center',
                    eval = false,
                },

                {
                    name = "recording",
                    callback = function(event)
                        local rec = vim.fn.reg_recording()

                        if rec == '' or event.event == "RecordingLeave" then
                            return ''
                        else
                            return ' rec: @' .. rec
                        end
                    end,
                    highlight = '',
                    event = { 'RecordingEnter', 'RecordingLeave' },
                    position = 'center',
                    eval = false,
                },

                {
                    name = 'position',
                    callback = function()
                        return '%l,%c%V '
                    end,
                    highlight = '',
                    event = { 'CursorMoved', 'CursorMovedI' },
                    position = 'right',
                    eval = true,
                },
            },
        })
    end
}
