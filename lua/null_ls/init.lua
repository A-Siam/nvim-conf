local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.diagnostics.pmd.with({
            extra_args = {
                "--no-cache",
                "--rulesets",
                "category/java/bestpractices.xml,category/jsp/bestpractices.xml" -- or path to self-written ruleset
            },
        }),
    },
})
