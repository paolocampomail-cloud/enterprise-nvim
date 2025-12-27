-- ============================================================================
-- Neovim Keymaps Configuration
-- Fast and efficient keybinds for Rust and Assembly development
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- General Keybinds
-- ============================================================================

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- ============================================================================
-- Quit/Window Management (FIXED)
-- ============================================================================

local function smart_close()
  -- Count only normal (non-floating) windows
  local normal_wins = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "" then
      normal_wins = normal_wins + 1
    end
  end

  if normal_wins > 1 then
    -- Multiple normal windows: safe to close
    vim.cmd("close")
  else
    -- Last normal window: switch buffer or create empty
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs > 1 then
      vim.cmd("bprevious")
      pcall(vim.cmd, "bdelete #")
    else
      vim.cmd("enew")
      pcall(vim.cmd, "bdelete #")
    end
  end
end

keymap("n", "<leader>q", smart_close, { noremap = true, silent = true, desc = "Close window/buffer" })
keymap("n", "<leader>wc", smart_close, { noremap = true, silent = true, desc = "Close window/buffer" })
keymap("n", "<leader>Q", ":qa! <CR>", { noremap = true, silent = true, desc = "Force quit Neovim" })
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- ============================================================================
-- File Explorer (NvimTree)
-- ============================================================================
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>o", ":NvimTreeFocus<CR>", opts)

-- ============================================================================
-- Telescope (Fuzzy Finder)
-- ============================================================================
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)
keymap("n", "<leader>fk", ":Telescope keymaps<CR>", opts)
keymap("n", "<leader>fs", ":Telescope grep_string<CR>", opts)

-- ============================================================================
-- LSP Keybinds (Fixed Overlaps for Neovim 0.11)
-- ============================================================================
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)

-- FIXED: Moved from 'gr', 'gi', 'gt' to avoid conflict with Neovim 0.11 built-ins
keymap("n", "<leader>lr", vim.lsp.buf.references, opts)
keymap("n", "<leader>li", vim.lsp.buf.implementation, opts)
keymap("n", "<leader>lt", vim.lsp.buf.type_definition, opts)

keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

-- FIXED: Changed <leader>f to <leader>lf (LSP Format) to enable Telescope instant-triggering
keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)

-- Diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "]d", vim.diagnostic.goto_next, opts)

-- FIXED: Changed <leader>d to <leader>df (Diagnostic Float) to free up <leader>d for Debugging
keymap("n", "<leader>df", vim.diagnostic.open_float, opts)
keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)

-- ============================================================================
-- Rust Specific Keybinds
-- ============================================================================
keymap("n", "<leader>rr", ":RustRunnables<CR>", opts)
keymap("n", "<leader>rd", ":RustDebuggables<CR>", opts)
keymap("n", "<leader>rt", ":Cargo test<CR>", opts)
keymap("n", "<leader>rc", ":Cargo check<CR>", opts)
keymap("n", "<leader>rb", ":Cargo build<CR>", opts)
keymap("n", "<leader>ru", ":Cargo update<CR>", opts)

-- ============================================================================
-- GitHub Copilot
-- ============================================================================
keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true, script = true })
keymap("i", "<C-n>", "<Plug>(copilot-next)", opts)
keymap("i", "<C-p>", "<Plug>(copilot-previous)", opts)
keymap("i", "<C-\\>", "<Plug>(copilot-dismiss)", opts)

-- Copilot Chat
-- FIXED: Changed <leader>cc to <leader>cq (Copilot Quickchat) to avoid Quickfix conflict
keymap("n", "<leader>cq", ":CopilotChat<CR>", opts)
keymap("n", "<leader>ce", ":CopilotChatExplain<CR>", opts)
keymap("n", "<leader>cr", ":CopilotChatReview<CR>", opts)
keymap("n", "<leader>cf", ":CopilotChatFix<CR>", opts)
keymap("n", "<leader>co", ":CopilotChatOptimize<CR>", opts)
keymap("n", "<leader>cd", ":CopilotChatDocs<CR>", opts)
keymap("n", "<leader>ct", ":CopilotChatTests<CR>", opts)
keymap("v", "<leader>cc", ":CopilotChatVisual<CR>", opts)

-- Copilot Model Selection
keymap("n", "<leader>cm", ":CopilotChatModels<CR>", opts)

-- ============================================================================
-- Toggle Terminal
-- ============================================================================
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- ============================================================================
-- Theme Transparency Toggle
-- ============================================================================
keymap("n", "<leader>tb", function()
  vim.g.transparent_background = not vim.g.transparent_background
  if vim.g.transparent_background then
    vim.cmd([[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi NvimTreeNormal guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE
      hi MsgArea guibg=NONE ctermbg=NONE
    ]])
    print("Transparent background enabled")
  else
    vim.cmd([[colorscheme gruvbox]])
    print("Solid background enabled")
  end
end, { noremap = true, silent = false, desc = "Toggle transparent background" })

-- ============================================================================
-- Git (Fugitive & Gitsigns)
-- ============================================================================
keymap("n", "<leader>gg", ":Git<CR>", opts)
keymap("n", "<leader>gp", ":Git push<CR>", opts)
keymap("n", "<leader>gP", ":Git pull<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>gd", ":Gitsigns diffthis<CR>", opts)
keymap("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", opts)

-- ============================================================================
-- Comment
-- ============================================================================
keymap("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, opts)
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- ============================================================================
-- Trouble (Better diagnostics)
-- ============================================================================
keymap("n", "<leader>xx", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts)
keymap("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts)
keymap("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts)

-- ============================================================================
-- DAP (Debugger)
-- ============================================================================
keymap("n", "<F5>", ":DapContinue<CR>", opts)
keymap("n", "<F10>", ":DapStepOver<CR>", opts)
keymap("n", "<F11>", ":DapStepInto<CR>", opts)
keymap("n", "<F12>", ":DapStepOut<CR>", opts)
keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<leader>dr", ":DapToggleRepl<CR>", opts)
keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", opts)

-- ============================================================================
-- Quick Fix List (Fixed Overlaps)
-- ============================================================================
-- FIXED: Changed to upper-case to avoid conflict with Copilot
keymap("n", "<leader>cO", ":copen<CR>", opts)
keymap("n", "<leader>cX", ":cclose<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)

-- ============================================================================
-- Assembly Specific
-- ============================================================================
keymap("n", "<leader>aa", ":!nasm -f elf64 % -o %:r.o<CR>", opts)
keymap("n", "<leader>al", ":!ld %:r.o -o %:r<CR>", opts)
keymap("n", "<leader>ar", ":!./%:r<CR>", opts)

-- ============================================================================
-- Dashboard / Home Screen
-- ============================================================================
-- Uncomment the one matching your dashboard plugin:

-- For Alpha.nvim (most common):
keymap("n", "<leader>h", ":Alpha<CR>", { noremap = true, silent = true, desc = "Go to dashboard" })

-- For Dashboard.nvim:
-- keymap("n", "<leader>h", ":Dashboard<CR>", { noremap = true, silent = true, desc = "Go to dashboard" })

-- For Startify:
-- keymap("n", "<leader>h", ":Startify<CR>", { noremap = true, silent = true, desc = "Go to dashboard" })-- ============================================================================
-- Which-key group registrations (new spec)
-- ============================================================================
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>a", group = "+assembly" },
    { "<leader>b", group = "+buffer" },
    { "<leader>c", group = "+copilot" },
    { "<leader>d", group = "+debug/diagnostics" },
    { "<leader>f", group = "+find" },
    { "<leader>g", group = "+git" },
    { "<leader>r", group = "+rust" },
    { "<leader>t", group = "+terminal/toggle" },
    { "<leader>x", group = "+trouble" },
  })
end
