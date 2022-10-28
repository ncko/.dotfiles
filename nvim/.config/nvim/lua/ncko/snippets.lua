local M = {}

-- https://github.com/rafamadriz/friendly-snippets/tree/main/snippets
local snippets = {
    "html",
    "gitcommit",
    "markdown",
    "php",
    "shell",
    "python",
    "go"
    -- "css",
    -- "scss",
    -- "html",
    -- "lua",
    -- "sql",
    -- "javascript",
}

function M.setup()
    require("luasnip.loaders.from_vscode").load({ include = snippets })
    require("luasnip.loaders.from_vscode").load({ paths = { "./ncko-snippets" } })
end

return M
