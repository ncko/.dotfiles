local M = {}

function M.setup()
    require("lspconfig")["intelephense"].setup{
        on_attach = require("ncko.languages.on_attach").on_attach,
        flags = {
            debounce_text_changes = 150
        }
    }
end

return M
