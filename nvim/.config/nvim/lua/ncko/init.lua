-- https://github.com/nanotee/nvim-lua-guide

require("ncko.set")
require("ncko.packer")

vim.cmd "colorscheme gruvbox"

require("ncko.whichkey").setup()
require("ncko.treesitter").setup()

