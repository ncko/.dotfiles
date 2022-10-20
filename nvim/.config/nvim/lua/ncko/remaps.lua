local keymap = require("ncko.keymap")
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap

nnoremap("<leader><CR>", ":luafile ~/.dotfiles/nvim/.config/nvim/init.lua<CR>")
nnoremap("<leader>pv", ":Vex<CR>")

-- window navigation
nnoremap("<leader>k", ":wincmd k<CR>")
nnoremap("<leader>l", ":wincmd l<CR>")
nnoremap("<leader>j", ":wincmd j<CR>")
nnoremap("<leader>h", ":wincmd h<CR>")

-- telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>") -- search for string project wide
nnoremap("<leader>fc", ":Telescope current_buffer_fuzzy_find<CR>") -- search in current buffer
nnoremap("<leader>fb", ":Telescope buffers<CR>")
nnoremap("<leader>fh", ":Telescope help_tags<CR>")
nnoremap("<leader>fgc", ":Telescope git_commits<CR>") -- fuzzy find git commits
-- nnoremap("<leader>fgs", ":Telescope git_stash<CR>") -- fuzzy find git stashes
-- nnoremap("<leader>fts", ":Telescope treesitter<CR>") -- treesitter
nnoremap("<leader>ftb", ":Telescope builtin<CR>") -- fuzzy find all telescope builtins


-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
inoremap("<c-space>", "coc#refresh()")

