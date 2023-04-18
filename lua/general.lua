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
vim.keymap.set('n', '<leader>tt', ":tabnew<CR>:term ".. os.getenv("MAIN_SHELL") .. "<CR>a", {})
vim.keymap.set('n', '<leader>gg', ":LazyGit<CR>", {})
vim.keymap.set('n', '<leader>nh', ":noh<CR>", {})
vim.keymap.set('i', '<c-s>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
vim.keymap.set('i', '<Tab>', "<cmd>lua require('luasnip').jump(1)<Cr>", {})
vim.keymap.set('i', '<S-Tab>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {})
vim.keymap.set('s', '<Tab>', "<cmd>lua require('luasnip').jump(1)<Cr>", {})
vim.keymap.set('s', '<S-Tab>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {})

