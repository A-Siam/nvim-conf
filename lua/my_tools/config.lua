local create_x = require("create_x")
local vim = vim
-- create_x.create_class("/root/src/main/java/example/package_yay/Init.java")
create_x.create_class(vim.fn.expand(vim.api.nvim_buf_get_name(0)))
