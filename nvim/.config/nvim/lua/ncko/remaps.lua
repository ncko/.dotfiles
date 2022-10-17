local nnoremap = require("ncko.keymap").nnoremap

nnoremap("<leader><CR>", ":luafile %<CR>")
nnoremap("<leader>pv", ":Vex<CR>")

-- window navigation
nnoremap("<leader>k", ":wincmd k<CR>")
nnoremap("<leader>l", ":wincmd l<CR>")
nnoremap("<leader>j", ":wincmd j<CR>")
nnoremap("<leader>h", ":wincmd h<CR>")

