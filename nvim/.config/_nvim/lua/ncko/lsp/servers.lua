local M = {}

local servers = {
    'intelephense', -- php
    'pyright', -- pyright
    'tsserver', -- typescript / javascript
    'tflint', -- terraform
    'terraformls', -- terraform
    'gopls', -- go
    'sumneko_lua', -- lua
    'html', -- html
    'jsonls' -- json
}

function M.setup()
    local lspconfig = require('lspconfig')
    local on_attach = require("ncko.lsp.on_attach").on_attach

    for _, server in ipairs(servers) do
        lspconfig[server].setup{
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 }
        }
    end

end

return M
