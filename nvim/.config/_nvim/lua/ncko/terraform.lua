local M = {}

function M.setup()

    -- https://mukeshsharma.dev/2022/02/08/neovim-workflow-for-terraform.html
    -- recognize the hcl and terraform filetype
    vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
    vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
    vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
    vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
    vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

        -- automatically format *.tf and *.tfvars files with terraform fmt on save and align settings.
    vim.cmd([[let g:terraform_fmt_on_save=1]])
    vim.cmd([[let g:terraform_align=1]])

    -- call the terraformls and tflint PID to attach as client to the Neovim LSP
    require'lspconfig'.terraformls.setup{}
    require'lspconfig'.tflint.setup{}

end

return M
