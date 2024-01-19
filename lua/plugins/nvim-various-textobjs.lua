--- @type LazyPluginSpec
return {
    name = 'nvim-various-textobjs',
    [1] = 'chrisgrieser/nvim-various-textobjs',

    config = function()
        require("various-textobjs").setup({
            -- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
            -- set to 0 to only look in the current line
            lookForwardSmall = 5,

            -- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
            lookForwardBig = 15,

            -- use suggested keymaps (see overview table in README)
            useDefaultKeymaps = false,

            -- disable only some default keymaps, e.g. { "ai", "ii" }
            disabledKeymaps = {},
        })

        require('marco.remaps.various-textobjs').apply()
    end,
}
