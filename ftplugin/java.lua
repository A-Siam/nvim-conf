local jdtls_installation_path = os.getenv('HOME') .. '/jdtls'
local workspace_root = os.getenv('HOME') .. '/java-workspaces'
local stylepath = os.getenv('HOME') .. '/style/eclipse-java-google-style.xml'
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        'java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '-javaagent:' .. os.getenv('HOME') .. '/lombok/lombok.jar',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar', jdtls_installation_path .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
    ,
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀
        '-configuration', jdtls_installation_path .. '/config_linux',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_root .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
    },
    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {}
    },
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
    on_attach = function()
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    end
}
-- This bundles definition is the same as in the previous section (java-debug installation)
local bundles = {
    vim.fn.glob("/root/java_dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        1),
};

-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob("/root/java_dap/vscode-java-test/server/*.jar", 1), "\n"))
config['init_options'] = {
    bundles = bundles,
}

vim.go.cmdheight = 2

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
vim.go.cmdheight = 2
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>oi', "<CMD>lua require('jdtls').organize_imports()<CR>", {})
vim.keymap.set('n', '<leader>ev', "<CMD>lua jdtls.extract_variable()<CR>", {})
vim.keymap.set('v', '<leader>ev', "<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>", {})
vim.keymap.set('n', '<leader>ec', "<CMD>lua require('jdtls').extract_constant()<CR>", {})
vim.keymap.set('v', '<leader>ec', "<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>", {})
vim.keymap.set('v', '<leader>em', "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>", {})
vim.keymap.set('n', '<leader><leader>d', "<CMD>lua require('jdtls.dap').setup_dap_main_class_configs()<CR>", {})

local dapui = require("dapui")
vim.keymap.set('n', '<space>dd', function()
    dapui.toggle()
    require('jdtls.dap').setup_dap_main_class_configs()
end, {})
vim.keymap.set('n', '<leader>cc', function()
    local create_x = require("my_tools.create_x")
    create_x.create_element()
end, {})
