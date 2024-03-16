return {
    {
        [1] = "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "copilot" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        event = "VeryLazy",

        config = function()
            require("CopilotChat").setup({
                window = {
                    layout = 'float',
                    -- Options below only apply to floating windows
                    relative = 'mouse', -- 'editor', 'win', 'cursor', 'mouse'
                    border = 'solid',   -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                }
            })
        end,
    },
}
