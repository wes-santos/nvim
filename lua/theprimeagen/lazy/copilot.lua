return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true
        vim.keymap.set("i", "<C-J>", function()
            local suggestion = vim.fn['copilot#Accept']("<CR>")

            if suggestion and #suggestion > 0 then
                -- Remove invalid characters like <80>@7
                suggestion = suggestion:gsub("[\128-\255]", "")
                suggestion = suggestion:gsub("@%d+", "")
                return suggestion
            end
            return suggestion
        end, { silent = true, expr = true })

        -- Disable copilot when in a floating window or certain buffer types
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
                if vim.bo.buftype == "nofile" then
                    vim.g.copilot_enabled = false
                end
            end,
            desc = "Disable Copilot in floating windows or nofile buffers",
        })

        -- Disable copilot when nvim-cmp is active
        vim.api.nvim_create_autocmd("User", {
            pattern = "CMPActive",
            callback = function()
                vim.g.copilot_enabled = false
            end,
            desc = "Disable Copilot when nvim-cmp is active",
        })
    end,
}
