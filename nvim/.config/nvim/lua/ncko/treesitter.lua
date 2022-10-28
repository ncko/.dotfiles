local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "html",
            "css",
            "scss",
            "javascript",
            "typescript",
            "python",
            "php",
            "phpdoc",
            "http",
            "sql",
            "bash",
            "dockerfile",
            "gitignore",
            "hcl",
            "help",
            "json",
            "lua",
            "markdown",
            "vim",
            "yaml",
            "go"
        },

        -- install parsers synchronously (only applied to ensure_installed)
        sync_install = false,

        -- automatically install missing parsers when entering buffer
        -- recommendation: set to false if you don't have 'tree-sitter' cli installed locally
        auto_install = true,

        -- list of parsers to ignore installing
        ignore_install = {},

        ---- if you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")
        
        hightlight = {
            -- 'false' will disable the whole extension
            enable = true,

            -- these are the names of the parsers, not the filetypes
            -- list of languages that will be disabled
            -- disable = {},
            -- or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            -- disable = function(lang, buf)
            --    local max_filesize = 100 * 1024 -- 100 kb
            --    local ok, stats = pcall(vim.loop.fs_state, vim.api.nvim_buf_get_name(buf)
            --    if ok and stats and stats.size > max_filesize then
            --        return true
            --    end
            --end
            
            -- setting this to true will run `:h syntax` and tree-sitter at the same time
            -- set this to true if you depend on 'syntax' being enabled (like for indentation)
            -- this options may slow down your editor, and you may see some duplicate highlights
            -- instead of true, it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
end

return M

