-- [[ BASIC SETTINGS ]]
vim.opt.number = true                -- Show line numbers
-- vim.opt.relativenumber = true        -- Relative line numbers
vim.opt.tabstop = 4                   -- Tab width
vim.opt.shiftwidth = 4                -- Auto-indent width
vim.opt.expandtab = true              -- Use spaces instead of tabs
vim.opt.smartindent = true            -- Auto-indent new lines
vim.opt.clipboard = "unnamedplus"     -- Use system clipboard
vim.opt.termguicolors = true          -- Enable 24-bit colors
vim.opt.ignorecase = true             -- Ignore case in search
vim.opt.smartcase = true              -- Case-sensitive if uppercase is used

-- Enable syntax highlighting
vim.cmd("syntax enable")

-- Set the color scheme to gruvbox
vim.cmd("colorscheme vim")

-- Set leader key
vim.g.mapleader = " "

-- [[ PLUGIN MANAGER: Lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]]
require("lazy").setup({
    "nvim-treesitter/nvim-treesitter",
    "nvim-lualine/lualine.nvim",
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "nvim-tree/nvim-tree.lua",
    "preservim/nerdtree",
    "morhetz/gruvbox"
})

-- [[ LSP CONFIGURATION ]]
local lspconfig = require("lspconfig")
lspconfig.pyright.setup{}  -- Python LSP
lspconfig.ts_ls.setup{} -- JavaScript/TypeScript LSP

-- [[ AUTOCOMPLETE CONFIG ]]
local cmp = require'cmp'
cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion manually
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },  -- Add snippet completion
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)  -- Use LuaSnip for snippet expansion
        end,
    },
})

-- [[ TREESITTER: Better Syntax Highlighting ]]
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = { enable = true }
}

-- [[ FILE EXPLORER: nvim-tree ]]
require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- [[ FUZZY FINDER: Telescope ]]
require("telescope").setup()
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- [[ STATUS LINE: Lualine ]]
require("lualine").setup {
    options = { theme = "auto" }
}

-- Automatically open NERDTree if no files are specified
vim.g.NERDTreeShowHidden = 1  -- Show hidden files

-- Close NERDTree when it's the last window
vim.g.NERDTreeQuitOnOpen = 1

-- Map Ctrl+S to save the file in normal and insert mode
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })


-- Map Ctrl+Q to quit Neovim in normal mode
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", ":q!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-b>', ':browse oldfiles<CR>', { noremap = true, silent = true })

