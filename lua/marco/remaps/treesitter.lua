local M = {}

M.apply = function()
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
end

M.select = {
    -- You can use the capture groups defined in textobjects.scm
    ["ae"] = { query = "@assignment.outer", desc = "Select outer part of an assignment [textobj]" },
    ["ie"] = { query = "@assignment.inner", desc = "Select inner part of an assignment [textobj]" },
    ["iE"] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment [textobj]" },
    ["aE"] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment [textobj]" },

    ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument [textobj]" },
    ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument [textobj]" },

    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional [textobj]" },
    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional [textobj]" },

    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop [textobj]" },
    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop [textobj]" },

    ["af"] = { query = "@call.outer", desc = "Select outer part of a function call [textobj]" },
    ["if"] = { query = "@call.inner", desc = "Select inner part of a function call [textobj]" },

    ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition [textobj]" },
    ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition [textobj]" },

    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class [textobj]" },
    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class [textobj]" },
}

M.swap = {
    swap_next = {
        ["<leader>na"] = { query = "@parameter.inner", desc = "swap parameters/argument with next [textobj]" },
        ["<leader>n:"] = { query = "@property.outer", desc = "swap object property with next [textobj]" },
        ["<leader>nm"] = { query = "@function.outer", desc = "swap function with next [textobj]" },
    },
    swap_previous = {
        ["<leader>pa"] = { query = "@parameter.inner", desc = "swap parameters/argument with prev [textobj]" },
        ["<leader>p:"] = { query = "@property.outer", desc = "swap object property with prev [textobj]" },
        ["<leader>pm"] = { query = "@function.outer", desc = "swap function with previous [textobj]" },
    },
}

M.move = {
    goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start [textobj]" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start [textobj]" },
        ["]c"] = { query = "@class.outer", desc = "Next class start [textobj]" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start [textobj]" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start [textobj]" },

        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope [textobj]" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold [textobj]" },
    },
    goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end [textobj]" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end [textobj]" },
        ["]C"] = { query = "@class.outer", desc = "Next class end [textobj]" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end [textobj]" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end [textobj]" },
    },
    goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start [textobj]" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start [textobj]" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start [textobj]" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start [textobj]" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start [textobj]" },
    },
    goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end [textobj]" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end [textobj]" },
        ["[C"] = { query = "@class.outer", desc = "Prev class end [textobj]" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end [textobj]" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end [textobj]" },
    },
}

M.incremental_selection = {
    init_selection = "<Leader><Leader>",
    scope_incremental = false,
    node_incremental = "<Leader><Leader>",
    node_decremental = false,
}

return M
