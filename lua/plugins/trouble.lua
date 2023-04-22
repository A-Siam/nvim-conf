require("trouble").setup {}

vim.keymap.set('n', '<leader>xx', "<CMD>TroubleToggle<CR>", {
    silent = true, noremap = true
})
vim.keymap.set('n', '<leader>xw', "<CMD>TroubleToggle<CR>", {
    silent = true, noremap = true
})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {
    silent = true, noremap = true
})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {
    silent = true, noremap = true
})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {
    silent = true, noremap = true
})
