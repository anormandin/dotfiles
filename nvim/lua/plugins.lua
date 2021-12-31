return require('packer').startup(function(use)

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Color scheme
    -- use { 'sainnhe/gruvbox-material' }
    use 'folke/tokyonight.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Status line
    use 'nvim-lualine/lualine.nvim'

    -- Treeview
    use 'kyazdani42/nvim-tree.lua'

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Buffer bar
    -- use {'romgrk/barbar.nvim', }

    -- LSP and completion
    use { 'neovim/nvim-lspconfig' }
    use { 'nvim-lua/completion-nvim' }

    -- Lua development
    use { 'tjdevries/nlua.nvim' }


    -- Vim dispatch
    use { 'tpope/vim-dispatch' }

    -- Vim commentary
    use { 'tpope/vim-commentary' }

    -- Vim surround
    use { 'tpope/vim-surround' }

    -- Fugitive for Git
    use { 'tpope/vim-fugitive' }

    use 'kdheepak/lazygit.nvim'
    
    
   use {'kevinhwang91/nvim-bqf', ft = 'qf'}

   use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

   use { 
       'jose-elias-alvarez/nvim-lsp-ts-utils',
       branch = 'main'
   }
   use { 
       'jose-elias-alvarez/null-ls.nvim',
       branch = 'main'
   }
   use { 
       'ray-x/lsp_signature.nvim'
   }

end)
