return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "-" },
            delete = { text = "_" },
            topdelete = { text = " " },
            changedelete = { text = "~" },
        },
        current_line_blame = true,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Define keymaps for gitsigns
            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Action
            map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select hunk<CR>')
        end,
    }
}
