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
    use 'williamboman/nvim-lsp-installer'
    use "L3MON4D3/LuaSnip"
    use { 'neovim/nvim-lspconfig' }
    use { 'nvim-lua/completion-nvim' }
    use "onsails/lspkind-nvim"

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"
    --
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
