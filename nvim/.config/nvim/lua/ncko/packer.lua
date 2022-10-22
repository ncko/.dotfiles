return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use("hrsh7th/nvim-cmp") -- autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
    use("saadparwaiz1/cmp_luasnip") -- snippets source for nvim-cmp
    use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- Snippets plugin
    use("rafamadriz/friendly-snippets")

    use("folke/which-key.nvim")
    -- use("sbdchd/neoformat") -- still trying to get this to work
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- color scheme
    use("gruvbox-community/gruvbox")

    -- terraform
    use("hashivim/vim-terraform")

    use("nvim-treesitter/nvim-treesitter", {
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    })
end)
