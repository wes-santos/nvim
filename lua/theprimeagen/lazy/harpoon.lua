return {
    dir = "~/.config/nvim/plugins/harpoon",
    -- branch = "harpoon2",
    dependencies = { dir = "~/.config/nvim/plugins/plenary.nvim" },
    config = function()
        require("harpoon"):setup()
    end,
    keys = {
        { "<leader>A", function() require("harpoon"):list():add() end },
        -- { "<leader>a", function() harpoon:list():add() end },
        { "<leader><C-e>", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end },
        { "<leader>1", function() require("harpoon"):list():select(1) end },
        { "<leader>2", function() require("harpoon"):list():select(2) end },
        { "<leader>3", function() require("harpoon"):list():select(3) end },
        { "<leader>4", function() require("harpoon"):list():select(4) end },
        { "<leader>5", function() require("harpoon"):list():select(5) end },
        { "<leader><C-1>", function() require("harpoon"):list():replace_at(1) end },
        { "<leader><C-2>", function() require("harpoon"):list():replace_at(2) end },
        { "<leader><C-3>", function() require("harpoon"):list():replace_at(3) end },
        { "<leader><C-4>", function() require("harpoon"):list():replace_at(4) end },
        { "<leader><C-5>", function() require("harpoon"):list():replace_at(5) end },
    },
}
