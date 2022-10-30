-- https://github.com/nanotee/nvim-lua-guide

require("ncko.set")
require("ncko.packer")
require("ncko.whichkey").setup()
require("ncko.treesitter").setup()

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "sumneko_lua" } })

require("ncko.completion").setup()
require("ncko.terraform").setup()
require("ncko.languages.php").setup()
require("ncko.snippets").setup()

vim.cmd "colorscheme gruvbox"
