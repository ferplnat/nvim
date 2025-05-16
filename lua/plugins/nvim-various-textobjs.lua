--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'nvim-various-textobjs',
    [1] = 'chrisgrieser/nvim-various-textobjs',

    config = function()
        require("various-textobjs").setup({
            forwardLooking = {
                -- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
                -- set to 0 to only look in the current line
                small = 5,

                -- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
                big = 15,
            },

            -- use suggested keymaps (see overview table in README)
            keymaps = {
                useDefaults = false,
            },
        })

        require('marco.remaps.various-textobjs').apply()
    end,
}
