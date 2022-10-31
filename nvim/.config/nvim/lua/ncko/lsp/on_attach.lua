local whichkey = require("which-key")

local function keymappings(client, bufnr)
    local mappings = {
        l = {
            g = {
                name = "Go to",
                D = { ":lua vim.lsp.buf.declaration()<cr>", "go to Declaration" },
                d = { ":lua vim.lsp.buf.definition()<cr>", "go to Definition" },
                i = { ":lua vim.lsp.buf.implementation()<cr>", "List implementations" },
                r = { ":lua vim.lsp.buf.references()<cr>", "List references" }
            },
            r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
            K = { ":lua vim.lsp.buf.hover()<cr>", "Display Hover" },
            k = { ":lua vim.lsp.buf.signature_help()<cr>", "Signature Info" },
            D = { ":lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
            c = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            f = { function() vim.lsp.buf.format { async = true } end, "Code Action" },
            w = {
                name = "Workspace",
                a = { ":lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace Folder" },
                r = { ":lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace Folder" },
                l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List Workspace Folders" },
            }
        }
    }

    local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false
    }

    if client.server_capabilities.document_formatting then
        mappings.l.f = { ":lua vim.lsp.buf.formatting()<cr>", "Format Document" }
    end

    whichkey.register(mappings, { buffer = bufnr, prefix = "<leader>" })
end

local M = {}

function M.on_attach(client, bufnr)
    -- `:h omnifunc` and `:h ins-completion`
    -- completion triggered by <C-X><C-O>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Use LSP as the handler for formatexpr
    -- `:h formatexpr`
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Configure key mappings
    keymappings(client, bufnr)
end

return M
