local vim = vim
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
vim.keymap.set('n', '<leader>tt', ":tabnew<CR>:term " .. os.getenv("MAIN_SHELL") .. "<CR>a", {})
vim.keymap.set('n', '<leader>gg', function()
    vim.cmd [[ wa ]]
    vim.cmd [[ LazyGit ]]
end, {})
vim.keymap.set('n', '<leader>nh', ":noh<CR>", {})
vim.keymap.set('i', '<c-s>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", {})
vim.cmd [[
    imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
    " -1 for jumping backwards.
    inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

    snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
    snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]]
