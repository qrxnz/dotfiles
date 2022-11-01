-- basics
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars:append("tab:> ")
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false

-- plug settings
require('plug/statusline.lualine')
require('plug/colorscheme.catppuccin')
require('plug/lsp.lsp')
