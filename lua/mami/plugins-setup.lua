-- Auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Autocommand that on save reloads neovim and installs/updates/removes plugins
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- Import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- List of plugins to install
return packer.startup(function(use)
  
  use('wbthomason/packer.nvim') -- paker can manage itself
  
  use('nvim-lua/plenary.nvim') -- lua functions that many plugins use

  use('bluz71/vim-nightfly-guicolors') -- prefered colorscheme
  --use('folke/tokyonight.nvim') -- prefered colorscheme
  
  use('christoomey/vim-tmux-navigator') -- tux & split window navigation
  use('szw/vim-maximizer') -- maximizes & restores current window
  
  use('tpope/vim-surround') -- add, delete, change surroundings(ys-w<Char>, ds<Char>, cs<Char1><Char2>)
  use('vim-scripts/ReplaceWithRegister') -- replace with register contents using motion(gr + motion)
 
  -- NOTE This does not work :(
  use('numToStr/Comment.nvim') -- commenting with gc
  
  use('nvim-tree/nvim-tree.lua') -- file explorer
  
  use('kyazdani42/nvim-web-devicons') -- file explorer icons
  
  use('nvim-lualine/lualine.nvim') -- statusline
 
  -- fuzzy finder
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- dependency for better sorting performance
  use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x' }) -- fuzzy finder

  -- autocompletion
  use('hrsh7th/nvim-cmp') -- completion plugin
  use('hrsh7th/cmp-buffer') -- source for text in buffer
  use('hrsh7th/cmp-path') -- source for file system paths

  -- snippets
  use({'L3MON4D3/LuaSnip', tag = 'v2.*', run = 'make install_jsregexp'}) -- snippet engine
  use('saadparwaiz1/cmp_luasnip') -- for autocompletion
  use('rafamadriz/friendly-snippets') -- useful snippets

    -- managing & installing lsp servers, linters & formatters
  use('williamboman/mason.nvim') -- in charge of managing lsp servers, linters & formatters
  use('williamboman/mason-lspconfig.nvim') -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  use('neovim/nvim-lspconfig') -- easily configure language servers
  use('hrsh7th/cmp-nvim-lsp') -- for autocompletion
  use({
    'glepnir/lspsaga.nvim',
    branch = 'main',
    requires = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  }) -- enhanced lsp uis
  use('jose-elias-alvarez/typescript.nvim') -- additional functionality for typescript server (e.g. rename file & update imports)
  use('simrat39/rust-tools.nvim') -- additional functionality for rust analyzer
  use('onsails/lspkind.nvim') -- vs-code like icons for autocompletion

  if packer_bootstrap then
    require('packer').sync()
  end
end)


