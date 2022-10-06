" EDITOR SETTINGS
set number
set relativenumber
set scrolloff=8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'EdenEast/nightfox.nvim'
call plug#end()

" COLOR SCHEME
set termguicolors
colorscheme nightfox

" REMAPS
" nnoremap <leader>pv :Vex<CR>
" n <- mode. Can be i=insert, v=visual, c=command, t=terminal
" nore <- no recursive execution.
" map <leader>pv :Vex<CR> <- map command: in normal mode, when I type <leaer>pv run :Vex<CR> command

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
