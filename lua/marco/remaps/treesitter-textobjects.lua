local M = {}

M.apply = function()
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
end

M.select = {
    -- You can use the capture groups defined in textobjects.scm
    ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
    ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
    ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
    ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

    ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
    ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

    ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
    ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

    ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
    ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
}

M.swap = {
    swap_next = {
        ["<leader>na"] = { query = "@parameter.inner", desc = "swap parameters/argument with next" },
        ["<leader>n:"] = { query = "@property.outer", desc = "swap object property with next" },
        ["<leader>nm"] = { query = "@function.outer", desc = "swap function with next" },
    },
    swap_previous = {
        ["<leader>pa"] = { query = "@parameter.inner", desc = "swap parameters/argument with prev" },
        ["<leader>p:"] = { query = "@property.outer", desc = "swap object property with prev" },
        ["<leader>pm"] = { query = "@function.outer", desc = "swap function with previous" },
    },
}

M.move = {
    goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
    },
    goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    },
    goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    },
    goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    },
}

return M
