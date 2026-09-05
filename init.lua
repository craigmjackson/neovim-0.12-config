-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Leader key workaround
vim.keymap.set("n", "<leader>s", "<Nop>", { noremap = true, silent = true })

-- Enable line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Enable mouse
vim.opt.mouse = "nvi"
-- Sync with OS clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
-- Make undo files
vim.opt.undofile = true
-- Ignore case in search
vim.opt.ignorecase = true
-- If there is a mixed case in your search, make it case-sensitive
vim.opt.smartcase = true
-- Only show sign column if needed
vim.opt.signcolumn = "yes"
-- Write swapfile to disk if no activity for 250ms
vim.opt.updatetime = 250
-- Timeout for other sequences
vim.opt.timeoutlen = 1000
-- Horizontal splits on the right
vim.opt.splitright = true
-- Vertical splits below
vim.opt.splitbelow = true
-- Hightlight the line with the cursor
vim.opt.cursorline = true
-- Keep some lines above and below the cursor
vim.opt.scrolloff = 5
-- Enable 256 colors in text mode
vim.opt.termguicolors = true
-- Transparency for floating windows
vim.opt.winblend = 30
-- Nerd fonts
vim.g.nerd_font = true
-- LSP keymaps
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- Install plugins if we can connect to github
require("plugins")
-- Highlighting autocmds
require("highlight")
-- Autocomplete
require("autocomplete")
-- Inlay hints
require("inlay_hints")
-- Diagnostics
require("diagnostics")
-- Theme
require("theme")
-- Icons
require("icons")
-- Filemanager
require("filemanager")
-- Picker
require("picker")
-- Git signs
require("git")
-- Statusline
require("statusline")
-- Breadcrumbs
require("breadcrumbs")
-- Tabs
require("tabs")
-- Formatting
require("formatting")
-- Scrollbar
require("scrollbar")
-- Autopairs
require("autopairs")
-- Indentation
require("indentation")
-- Zen mode
require("zenmode")
-- Hlslens
require("hls_lens")
-- Languages
require("languages.lua")
require("languages.rust")
require("languages.python")
require("languages.bash")
require("languages.javascript")
require("languages.vue")
require("languages.markdown")
require("languages.json")
require("languages.html")
require("languages.css")
require("languages.sql")
require("languages.yaml")
require("languages.toml")
require("languages.c_cpp")
require("languages.php")
require("languages.csharp")
require("languages.go")
-- See ftplugin/java.lua for Java enablement
