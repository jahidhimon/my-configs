local wk = require('whichkey_setup')

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', opts)
vim.g.mapleader=' '

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', opts)
vim.api.nvim_set_keymap('v', '>', '>gv', opts)

-- buffer switch
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-p>', ':bprevious<CR>', opts)

-- Move Block/Line Up/Down in visual mode
vim.api.nvim_set_keymap('x', '<C-K>', ':move \'<-2<CR>gv-gv' ,opts)
vim.api.nvim_set_keymap('x', '<C-J>', ':move \'>+1<CR>gv-gv' ,opts)

require("whichkey_setup").config{
    hide_statusline = true,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
    default_mode = 'n',
}

local keymap = {
  q = {':bw<CR>', 'buffer close'}, -- set a single command and text
  h = {':set hlsearch!<CR>', 'no_highlight'}, -- set a single command and text
  -- x = {'q:i', 'no_highlight'}, -- set a single command and text
  e = {
    name = "+Explorer",
    e = {':NvimTreeToggle<CR>', 'toggle'},
    r = {':NvimTreeRefresh<CR>', 'refresh'},
    s = {':NvimTreeResize ', 'resize'},
    v = {':NvimTreeClipboard<CR>', 'clipboard'},
  },
  w = { -- Windows
    name = '+Windows',
    w = {'<Plug>(choosewin)', 'choose'},
    h = {'<C-w>h', 'focus left'},
    j = {'<C-w>j', 'focus down'},
    k = {'<C-w>k', 'focus up'},
    l = {'<C-w>l', 'focus right'},
    J = {':resize +5<CR>', 'height +5'},
    K = {':resize -5<CR>', 'height -5'},
    H = {'<C-w>5>', 'width +5'},
    L = {'<C-w>5<', 'width -5'},
    c = {':q<CR>', 'window close'},
    q = {':q!<CR>', 'window quit'},
  },
  f = { -- FZF
    name = '+Find',
    f = {':Files<CR>', 'files'},
    o = {':Buffers<CR>', 'opened_buffers'},
    l = {':Lines<CR>', 'lines'},
    m = {':Maps<CR>', 'lines'},
    t = {':Tags<CR>', 'tags'},
    c = {':Colors<CR>', 'colors'},
    b = {
      name = 'Buffer',
      l = {':BLines<CR>', 'lines'},
      t = {':BTags<CR>', 'tags'},
      c = {':BCommits<CR>', 'commits'},
    },
  },
  c = { -- Coc
    name = '+Coc',
    d = 'diagnostics',
    e = {':<C-u>CocList extensions<CR>', 'extensions'},
    c = {':<C-u>CocList commands<CR>', 'commands'},
    o = {':<C-u>CocList outline<CR>', 'outlines'},
    s = {':<C-u>CocList -I symbols<CR>', 'symbols'},
    n = {':<C-u>CocNext<CR>', 'cocNext'},
    p = {':<C-u>CocPrev<CR>', 'cocPrev'},
    r = {':<C-u>CocListResume<CR>', 'resume_list'},
    a = "codeaction",
    f = "fix-current"
  },
  r = {
    name = "+Refactor",
    r = "refactor",
    s = {':%s//gIc<Left><Left><Left><Left>', 'search&replace'},
  },
}

wk.register_keymap('leader', keymap)
