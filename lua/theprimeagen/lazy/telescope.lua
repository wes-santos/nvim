return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { silent = true, noremap = true })
        vim.keymap.set('n', 'gr', builtin.lsp_references, { silent = true, noremap = true })
        vim.keymap.set('n', 'gi', builtin.lsp_implementations, { silent = true, noremap = true })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { silent = true, noremap = true })
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { silent = true, noremap = true })
        vim.keymap.set('n', '<leader>km', function() vim.cmd("Telescope keymaps") end, { silent = true, noremap = true})
    end
}

