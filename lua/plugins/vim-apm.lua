--- @type LazyPluginSpec
return {
    name = "vim-apm",
    [1] = "ThePrimeagen/vim-apm",

    config = function()
        local apm = require("vim-apm")
        apm:setup({})

        require("marco.remaps.vim-apm").apply(apm)
        apm:toggle_monitor()
    end,
}
