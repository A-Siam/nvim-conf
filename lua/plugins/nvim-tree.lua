require("nvim-tree").setup {
    renderer = {
	group_empty = true
    }
}

vim.keymap.set('n', '<space>bb', "<CMD>NvimTreeToggle<CR>", {})

