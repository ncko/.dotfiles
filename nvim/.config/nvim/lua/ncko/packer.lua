return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("sbdchd/neoformat")

    -- color scheme
    use {
    "sainnhe/everforest",
    config = function()
    vim.cmd "colorscheme everforest"
    end
    }
end)
