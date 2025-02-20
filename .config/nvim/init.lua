vim.opt.clipboard = "unnamedplus"

-- Basic Settings
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

-- Package Manager Setup
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- LSP Support
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             
            {'williamboman/mason.nvim'},           
            {'williamboman/mason-lspconfig.nvim'}, 

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     
            {'hrsh7th/cmp-nvim-lsp'}, 
            {'L3MON4D3/LuaSnip'},     
        }
    }
    
    -- Treesitter for better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    
    -- Telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    
    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    
    -- Theme
    use { "catppuccin/nvim", as = "catppuccin" }
end)

-- Theme Setup
vim.cmd.colorscheme "slate"

-- LSP Setup
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Setup nvim-cmp for autocompletion
local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        ['<C-Space>'] = cmp.mapping.complete(),
    }
})

-- Treesitter Setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
}

-- Telescope Setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- NvimTree Setup
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})

-- Set leader key to space
vim.g.mapleader = " "

-- Configure clangd with disabled diagnostics
require'lspconfig'.clangd.setup{
    vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false
})    }
