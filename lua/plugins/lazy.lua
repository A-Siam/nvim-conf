-- download lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    'marko-cerovac/material.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },
    'hrsh7th/cmp-nvim-lua',
    'windwp/nvim-autopairs',
    { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    'mfussenegger/nvim-jdtls',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'nvim-lualine/lualine.nvim',
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    'APZelos/blamer.nvim',
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'mxsdev/nvim-dap-vscode-js',
    {
        'microsoft/vscode-js-debug',
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    'kdheepak/lazygit.nvim',
    'phaazon/hop.nvim',
    'SmiteshP/nvim-navic',
    'lewis6991/gitsigns.nvim',
    'simrat39/symbols-outline.nvim',
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'folke/trouble.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'mg979/vim-visual-multi',
    'nvim-telescope/telescope-ui-select.nvim',
    'b0o/schemastore.nvim',
    'shaunsingh/nord.nvim',
    'JMcKiern/vim-venter'
}
