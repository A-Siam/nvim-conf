local null_ls = require("null-ls")

null_ls.setup({
    sources = { null_ls.builtins.formatting.prettier }
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("Formatter", {clear = true}),
    callback = function ()
        vim.lsp.buf.format()
    end
})
