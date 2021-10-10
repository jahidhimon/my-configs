-- Bootstrapping Start 

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Bootstrapping End 

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }

  use 'navarasu/onedark.nvim'

  use {
    'vim-airline/vim-airline',
    requires = {'vim-airline/vim-airline-themes', opt = true}
  }
  
  use {'neoclide/coc.nvim', branch = 'release'}

  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use 'pangloss/vim-javascript'
  use 'maxmellon/vim-jsx-pretty'
  use 'burner/vim-svelte'

  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

  use 'jiangmiao/auto-pairs'

  use 'groenewege/vim-less'

  use 'jpalardy/vim-slime'                                                                                                                                            
  use 'tpope/vim-commentary'                                                                                                                                          
  use 'godlygeek/tabular'

  use {
    'AckslD/nvim-whichkey-setup.lua',
    requires = {'liuchengxu/vim-which-key'},
  }

end)
