-- Keymaps (centralized)
local map = vim.keymap.set

map("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim" })

-- Test the leader key: press <leader>tl (space, then t, then l)
-- Verify afterwards with:  :lua =vim.g.leader_test_count
map("n", "<leader>tl", function()
  vim.g.leader_test_count = (vim.g.leader_test_count or 0) + 1
  vim.notify("Leader key works! count=" .. vim.g.leader_test_count, vim.log.levels.INFO)
end, { desc = "Test leader key" })

map("x", "p", [["_dP]], { desc = "Paste over selection without losing the register" })

-- Navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Previous search centered" })

-- Window navigation (handled by vim-tmux-navigator for seamless tmux/nvim navigation)
-- Ctrl+h/j/k/l now works across both tmux panes and nvim windows

-- Window resize
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- -- Buffers
-- map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
-- map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
-- map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
-- map("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
--
-- Visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("x", "<leader>p", '"_dP', { desc = "Paste without overwrite" })

-- Quick actions
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Terminal
-- map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- -- -- Diagnostics
-- -- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
-- -- map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
-- -- map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
-- --
-- -- LSP (available after attaching)
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(event)
--     local opts = { buffer = event.buf }
--     map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
--     map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
--     map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
--     map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
--     map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
--     map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
--     map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
--     map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
--     map("n", "<leader>cf", function()
--       require("conform").format({ async = true, lsp_fallback = true })
--     end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
--   end,
-- })
--
-- Telescope
-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
-- map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
-- map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
-- map("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find word" })
--
-- -- -- -- Git
-- -- -- map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
-- -- -- map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
-- -- --
-- -- -- Gitsigns (loaded lazily, so wrap in pcall)
-- -- vim.api.nvim_create_autocmd("User", {
-- --   pattern = "GitSignsAttach",
-- --   callback = function(event)
-- --     local gs = require("gitsigns")
-- --     local opts = { buffer = event.buf }
-- --     map("n", "]c", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
-- --     map("n", "[c", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Previous hunk" }))
-- --     map("n", "<leader>gp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
-- --     map("n", "<leader>gb", gs.blame_line, vim.tbl_extend("force", opts, { desc = "Blame line" }))
-- --   end,
-- -- })
-- --
-- -- File explorer
-- map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
-- map("n", "<leader>fe", ":Neotree reveal<CR>", { desc = "Reveal in explorer" })
