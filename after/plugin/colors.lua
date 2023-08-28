function ColorMyPencils(color)
	color = color or 'monokai-pro'

    if (color == 'monokai-pro')
    then
        require('monokai-pro').setup({})
        vim.cmd.colorscheme(color)
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#6b5000" })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#6b5000" })
        vim.api.nvim_set_hl(0, "Cursor", { bg = "#fc9867", fg = "#fc9867" })
    end

    if (color == 'kanagawa') then
        local kanagawa = require('kanagawa')
        kanagawa.setup({
            compile = false,             -- enable compiling the colorscheme
            undercurl = true,            -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true},
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,         -- do not set background color
            dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            terminalColors = true,       -- define vim.g.terminal_color_{0,17}
            colors = {                   -- add/modify theme and palette colors
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
            overrides = function(colors) -- add/modify highlights
                local theme = colors.theme
                return {
                    -- Popup menu
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    -- Other overrides
                    Normal = { bg = "none" },
                    NormalFloat = { bg = "none" },
                    Visual = { bg = "#6b5000" },
                    ColorColumn = { bg = "#6b5000" },
                    Cursor = { bg = "#fc9867", fg = "#fc9867" },

                    -- Theme color overrides
                    Todo = { bg = "none", fg = theme.syn.special1, underline = true, italic = true, bold = true }, -- TODO: Example
                    ["@text.note"] = { link = "Todo" }, -- NOTE: Example
                    ["@parameter"] = { italic = true },
                    Operator = { fg = colors.palette.lightBlue },
                    Boolean = { italic = true },
                }
            end,
            theme = "wave",            -- Load "wave" theme when 'background' option is not set
            background = {               -- map the value of 'background' option to a theme
                dark = "wave",           -- try "dragon" !
                light = "lotus"
            },
        })

        vim.cmd.colorscheme(color)
    end
end

ColorMyPencils('kanagawa')
