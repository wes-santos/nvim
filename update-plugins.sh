#!/bin/bash

declare -A plugins=(
  ["Comment.nvim"]="https://github.com/numToStr/Comment.nvim.git"
  ["nvim-treesitter"]="https://github.com/nvim-treesitter/nvim-treesitter.git"
  ["lualine.nvim"]="https://github.com/nvim-lualine/lualine.nvim.git"
  ["cloak.nvim"]="https://github.com/laytan/cloak.nvim.git"
  ["gitsigns.nvim"]="https://github.com/lewis6991/gitsigns.nvim.git"
  ["iron.nvim"]="https://github.com/Vigemus/iron.nvim.git"
  ["LuaSnip"]="https://github.com/L3MON4D3/LuaSnip.git"
  ["telescope.nvim"]="https://github.com/nvim-telescope/telescope.nvim.git"
  ["undotree"]="https://github.com/mbbill/undotree.git"
  ["copilot.vim"]="https://github.com/github/copilot.vim.git"
  ["friendly-snippets"]="https://github.com/rafamadriz/friendly-snippets.git"
  # ["harpoon"]="https://github.com/ThePrimeagen/harpoon.git"
  ["neoterm"]="https://github.com/kassio/neoterm.git"
  ["plenary.nvim"]="https://github.com/nvim-lua/plenary.nvim.git"
  ["trouble.nvim"]="https://github.com/folke/trouble.nvim.git"
  ["vim-fugitive"]="https://github.com/tpope/vim-fugitive.git"
  ["colors/brightburn.vim"]="https://github.com/erikbackman/brightburn.vim.git"
  ["colors/gruvbox.nvim"]="https://github.com/ellisonleao/gruvbox.nvim.git"
  ["colors/tokyonight.nvim"]="https://github.com/folke/tokyonight.nvim.git"
  ["dap/nvim-dap"]="https://github.com/mfussenegger/nvim-dap.git"
  ["dap/nvim-dap-python"]="https://github.com/mfussenegger/nvim-dap-python.git"
  ["dap/nvim-dap-ui"]="https://github.com/rcarriga/nvim-dap-ui.git"
  ["dap/nvim-dap-virtual-text"]="https://github.com/theHamsta/nvim-dap-virtual-text.git"
  ["dap/nvim-nio"]="https://github.com/nvim-neotest/nvim-nio.git"
  ["dap/telescope-dap.nvim"]="https://github.com/nvim-telescope/telescope-dap.nvim.git"
  ["lsp/cmp-buffer"]="https://github.com/hrsh7th/cmp-buffer.git"
  ["lsp/cmp-cmdline"]="https://github.com/hrsh7th/cmp-cmdline.git"
  ["lsp/cmp-nvim-lsp"]="https://github.com/hrsh7th/cmp-nvim-lsp.git"
  ["lsp/cmp-path"]="https://github.com/hrsh7th/cmp-path.git"
  ["lsp/cmp_luasnip"]="https://github.com/saadparwaiz1/cmp_luasnip.git"
  ["lsp/conform.nvim"]="https://github.com/stevearc/conform.nvim.git"
  ["lsp/fidget.nvim"]="https://github.com/j-hui/fidget.nvim.git"
  ["lsp/mason-lspconfig.nvim"]="https://github.com/williamboman/mason-lspconfig.nvim.git"
  ["lsp/mason.nvim"]="https://github.com/williamboman/mason.nvim.git"
  ["lsp/nvim-cmp"]="https://github.com/hrsh7th/nvim-cmp.git"
  ["lsp/nvim-lspconfig"]="https://github.com/neovim/nvim-lspconfig.git"
)

PLUGIN_DIR="$HOME/.config/nvim/plugins"

# Remove actual plugin folder and download it again
for plugin in "${!plugins[@]}"; do
  echo "Updating $plugin..."
  rm -rf "$PLUGIN_DIR/$plugin"
  git clone --depth=1 "${plugins[$plugin]}" "$PLUGIN_DIR/$plugin"
done

echo "All the plugins was updated!"
