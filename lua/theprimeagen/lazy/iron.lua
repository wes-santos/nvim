return {
    "hkupty/iron.nvim",
    config = function()
        require("iron.core").setup({
            config = {
                repl_definition = {
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste_python
                    },
                },
                repl_open_cmd = "vsplit",
            },
            keymaps = {
                send_motion = "<leader>sc",
                visual_send = "<leader>sc",
                send_file = "<leader>sf",
                send_line = "<space>sl",
                send_paragraph = "<space>sp",
                send_until_cursor = "<space>su",
                send_mark = "<space>sm",
                mark_motion = "<space>mc",
                mark_visual = "<space>mc",
                remove_mark = "<space>md",
                cr = "<space>s<cr>",
                interrupt = "<space>s<space>",
                exit = "<space>sq",
                clear = "<space>cl",
            }
        })
    end,
}
