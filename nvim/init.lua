require('opts')
require('keymappings')
require('theme_config')
require('treesitter_setup')
require('plugins')

vim.cmd 'source ~/.config/nvim/vim/coc_setup.vim'
vim.cmd 'source ~/.config/nvim/vim/other_setup.vim' -- airline, tabular, slime, gitgutter
