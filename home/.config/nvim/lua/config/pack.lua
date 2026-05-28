vim.pack.add({
  -- "https://github.com/folke/tokyonight.nvim",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", { branch = "main" } },
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim",     { branch = "v3.x" } },
})


-- mini basics config
require("mini.basics").setup()

-- miniFiles
local MiniFiles = require("mini.files")
MiniFiles.setup({
  mappings = {
    go_in = "<CR>",
    go_in_plus = "L",
    go_out = "-",
    go_out_plus = "H",
  }
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  MiniFiles.reveal_cwd()
end, { desc = "Open mini file explorer" })


-- mini Notify
require("mini.notify").setup({
  content = {
    format = function(notif)
      return notif.msg
    end,
  },
})

-- mini cmdline completion
require("mini.cmdline").setup({
  autocorrect = { enable = false }
})

-- mini surround
require("mini.surround").setup()

-- mini picker
local MiniPick = require("mini.pick")
MiniPick.setup()

vim.keymap.set("n", "<leader>sf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>ss", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,
  { desc = "Mini grep" })
vim.keymap.set("n", "<leader>sh", function() MiniPick.builtin.help() end, { desc = "Search Help" })

-- mini extra
local MiniExtra = require("mini.extra")
vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini diag" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = "Mini diag keymaps" })

-- mini comment
require("mini.comment").setup()


-- mini autopair
require("mini.pairs").setup()


-- mini completion
local MiniComp = require("mini.completion")
MiniComp.setup({
  lsp_completion = {
    auto_setup = true,
  }
})

-- Vim Flash (jump around)
local Flash = require("flash")
Flash.setup()
vim.keymap.set("n", "s", function() Flash.jump() end, { desc = "Flash" })


-- mini snippets
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
  snippets = {
    MiniSnippets.gen_loader.from_lang(),
  }

})
MiniSnippets.start_lsp_server({ match = false })

-- Minidiff
local MiniDiff = require('mini.diff')
MiniDiff.setup({
  source = MiniDiff.gen_source.git({ index = false })
})

-- Default
-- gh stage hunk
-- gH reset hunk
-- [h and  ]h navigate hunks
vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<cr>", { desc = "Fugitive Full page new tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff split" })

-- neo-tree
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
  },
  window = {
    width = 35,
    mappings = {
      ["<space>"] = "none",
      ["l"] = "open",
      ["h"] = "close_node",
      ["<cr>"] = "open_and_close",
    },
  },
  commands = {
    open_and_close = function(state)
      local node = state.tree:get_node()
      if node.type == "file" then
        require("neo-tree.sources.filesystem.commands").open(state)
        vim.cmd("Neotree close")
      else
        require("neo-tree.sources.filesystem.commands").open(state)
      end
    end,
  },
  default_component_configs = {
    indent = { with_markers = true },
    git_status = {
      symbols = {
        added = "+",
        modified = "~",
        deleted = "-",
        renamed = "->",
        untracked = "?",
        ignored = "!",
        unstaged = "*",
        staged = "s",
        conflict = "!",
      },
    },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Neo-tree toggle" })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree reveal<cr>", { desc = "Neo-tree reveal current file" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status<cr>", { desc = "Neo-tree git status" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree buffers<cr>", { desc = "Neo-tree buffers" })

-- kanagawa
-- Default options:
require('kanagawa').setup({
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = { italic = false },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = true,    -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {             -- add/modify theme and palette colors
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  },
  overrides = function(colors) -- add/modify highlights
    return {}
  end,
  theme = "wave",  -- Load "wave" theme
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")

require('config.treesitter')
require('config.lsp')
