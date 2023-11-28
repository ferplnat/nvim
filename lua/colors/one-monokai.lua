local M = {}

M.apply = function()
    local theme = require('one_monokai.colors')

    require("one_monokai").setup({
        transparent = true,
        colors = {
        },
        themes = function(colors)
            local bg_dark = theme.bg:darken(0.5)
            local fg_dark = theme.fg:darken(0.5)

            return {
                Pmenu = { bg = theme.bg }, -- add `blend = vim.o.pumblend` to enable transparency
                PmenuSel = { fg = "NONE", bg = theme.bg_dark },
                PmenuSbar = { bg = theme.bg },
                PmenuThumb = { bg = theme.bg },

                FloatBorder = { bg = "none" },
                FloatTitle = { bg = "none" },

                -- Diagnostics
                DiagnosticFloatingError = { bg = theme.bg },
                DiagnosticFloatingWarn = { bg = theme.bg },
                DiagnosticFloatingInfo = { bg = theme.bg },
                DiagnosticFloatingHint = { bg = theme.bg },
                DiagnosticFloatingOk = { bg = theme.bg },

                -- Save an hlgroup with dark background and dimmed foreground
                -- so that you can use it where your still want darker windows.
                -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                NormalDark = { fg = fg_dark, bg = bg_dark },

                -- Popular plugins that open floats will link to NormalFloat by default;
                -- set their background accordingly if you wish to keep them dark and borderless
                LazyNormal = { bg = bg_dark, fg = fg_dark },

                -- Telescope
                TelescopeTitle = { bold = true },
                TelescopePromptNormal = { bg = theme.bg },
                TelescopePromptBorder = { fg = theme.bg, bg = theme.bg },
                TelescopeResultsNormal = { fg = fg_dark, bg = bg_dark },
                TelescopeResultsBorder = { fg = theme.bg, bg = theme.bg },
                TelescopePreviewNormal = { bg = bg_dark },
                TelescopePreviewBorder = { fg = bg_dark, bg = bg_dark },

                -- ToggleTerm
                ToggleTermNormal = { bg = theme.bg },
                ToggleTermStatusLine = { link = "StatusLine" },

                -- Harpoon
                HarpoonWindow = { bg = theme.bg },
                HarpoonBorder = { bg = theme.bg, bold = true },

                -- Other overrides
                Normal = { bg = "none" },
                NormalFloat = { bg = theme.bg },
                Visual = { bg = "#6b5000" },
                ColorColumn = { bg = "#6b5000" },
                Cursor = { bg = "#fc9867", fg = "#fc9867" },

                -- Theme color overrides
                Todo = { bg = "none", underline = true, italic = true, bold = true }, -- TODO: Example
                ["@text.note"] = { link = "Todo" },                                                        -- NOTE: Example
                ["@parameter"] = { italic = true },
                Boolean = { italic = true },

            }
        end,
        italics = true,
    })
end

return M
