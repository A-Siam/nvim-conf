local opt = vim.opt
local wo = vim.wo
local go = vim.go

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

wo.number = true
wo.rnu = true

go.ignorecase = true

-- general keymaps
vim.keymap.set('n', '<leader>tt', "<CMD>tab term ".. os.getenv("MAIN_SHELL") .. "<CR>", {})

