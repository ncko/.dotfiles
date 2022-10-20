return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("folke/which-key.nvim")

    use("sbdchd/neoformat") -- still trying to get this to work

    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'neoclide/coc.nvim',
        branch = 'release'
    }


    -- use {
        -- "neovim/nvim-lspconfig",
        -- opt = true,
        -- event = "BufReadPre",
        -- wants = { "nvim-lsp-installer" },
        -- config = function()
            -- require("config.lsp").setup()
        -- end,
        -- requires = {
            -- "williamboman/nvim-lsp-installer",
        -- },
    -- }

    -- color scheme
    use("sainnhe/everforest")
    use("gruvbox-community/gruvbox")

    use("nvim-treesitter/nvim-treesitter", {
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    })
end)
