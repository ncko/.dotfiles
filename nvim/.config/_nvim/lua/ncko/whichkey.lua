local M = {}

function M.setup()
    local whichkey = require("which-key")

    whichkey.setup {
        -- config goes here
    }

    local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
        silent = true, -- use silent when creating keymaps
        noremap = true, -- use noremap when creating keymaps
        nowait = false, -- use nowait when creating keymaps
    }

    local mappings = {
        ["<CR>"] = { ":luafile ~/.dotfiles/nvim/.config/nvim/lua/ncko/init.lua<CR>", "Source Lua Config" },
        w = { -- window
            name = "Window",
            k = { ":wincmd k<CR>", "Up" },
            l = { ":wincmd l<CR>", "Right" },
            j = { ":wincmd j<CR>", "Down" },
            h = { ":wincmd h<CR>", "Left" },
            v = { ":Vex<CR>", "Vertical Split" },
            s = { ":Sex<CR>", "Horizontal Split" },
        },
        f = { -- Find
            name = "Find",
            f = { ":Telescope find_files<CR>", "Find File" },
            c = { ":Telescope current_buffer_fuzzy_find<CR>", "Search in Current Buffer" },
            b = { ":Telescope buffers<CR>", "Find Buffer" },
            g = { ":Telescope live_grep<CR>", "Find String in Project" },
            t = { ":Telescope treesitter<CR>", "Find Symbol" }, -- treesitter
            -- h = { ":Telescope help_tags<CR>", "Find Help" },
            h = {
                name = "Harpoon",
                m = { ":lua require('harpoon.mark').add_file()<cr>", "Mark a file" },
                p = { ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle marks menu" },
                h = { ":Telescope harpoon marks<cr>", "Find marks" },
            }
        },
        l = { -- LSP
            name = "LSP",
            d = { -- disagnostics
                e = { ":lua vim.diagnostic.open_float()<cr>" , "Open Disagnostic Float" }, -- TODO: troubleshoot
                ["["] = { ":lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
                ["]"] = { ":lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
                q = { ":lua vim.diagnostic.setloclist()<cr>", "Add diagnostics to location list" },
            }
        }
    }
    whichkey.register(mappings, opts)
end


return M
