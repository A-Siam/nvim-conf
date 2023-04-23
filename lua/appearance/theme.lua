-- theme setup
require('material').setup({
    contrast = {
        terminal = false,            -- Enable contrast for the built-in terminal
        sidebars = true,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false,    -- Enable contrast for floating windows
        cursor_line = false,         -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
    },
    plugins = {                      -- Uncomment the plugins that you use to highlight them
        "nvim-tree",
        "nvim-web-devicons",
        "trouble",
    },
    disable = {
        colored_cursor = true, -- Disable the colored cursor
         borders = true,
    },
    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false   -- Enable higher contrast text for darker style
    },
})

vim.cmd [[ colorscheme material ]]
