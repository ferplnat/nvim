local M = {}

M.apply = function()
    vim.cmd.colorscheme('kanagawa')
end

local kanagawa = require('kanagawa')
kanagawa.setup({
    theme = "dragon",         -- Load "wave" theme when 'background' option is not set

    compile = false,          -- enable compiling the colorscheme
    undercurl = true,         -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,            -- do not set background color
    dimInactive = false,           -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,         -- define vim.g.terminal_color_{0,17}
    colors = {                     -- add/modify theme and palette colors
        palette = {},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg_gutter = "none"
                }
            },
        },
    },
    overrides = function(colors)         -- add/modify highlights
        local theme = colors.theme

        return {
            -- Popup menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },         -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Diagnostics
            DiagnosticFloatingError = { fg = theme.diag.error, bg = theme.ui.bg_p1 },
            DiagnosticFloatingWarn = { fg = theme.diag.warning, bg = theme.ui.bg_p1 },
            DiagnosticFloatingInfo = { fg = theme.diag.info, bg = theme.ui.bg_p1 },
            DiagnosticFloatingHint = { fg = theme.diag.hint, bg = theme.ui.bg_p1 },
            DiagnosticFloatingOk = { fg = theme.diag.ok, bg = theme.ui.bg_p1 },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            -- Telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            -- ToggleTerm
            ToggleTermNormal = { bg = theme.ui.bg_p1 },
            ToggleTermStatusLine = { link = "StatusLine" },

            -- Harpoon
            HarpoonWindow = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
            HarpoonBorder = { bg = theme.ui.bg_p1, bold = true },

            -- Other overrides
            Normal = { bg = "none" },
            NormalFloat = { bg = theme.ui.bg_p1 },
            Visual = { bg = "#6b5000" },
            ColorColumn = { bg = "#6b5000" },
            Cursor = { bg = "#fc9867", fg = "#fc9867" },

            -- Theme color overrides
            Todo = { bg = "none", fg = theme.syn.special1, underline = true, italic = true, bold = true },         -- TODO: Example
            ["@text.note"] = { link = "Todo" },                                                                    -- NOTE: Example
            ["@parameter"] = { italic = true },
            Operator = { fg = colors.palette.lightBlue },
            Boolean = { italic = true },
        }
    end,
})

return M
