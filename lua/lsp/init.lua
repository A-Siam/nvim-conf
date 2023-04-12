-- initialize LSPs

local pyright_setup = require("lsp/pyright")

-- pyright
require'lspconfig'.pyright.setup(pyright_setup)

-- general config
require("lsp/config")
