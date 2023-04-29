local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
    formatting.prettierd,
    lint.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs"})
        end,
    })
}

null_ls.setup {
    debug = true,
    sources = sources,
}

