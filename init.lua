-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Leader key workaround
vim.keymap.set('n', '<leader>s', '<Nop>', { noremap = true, silent = true })
-- Press Esc to cancel search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap=true })
-- Enable line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Enable mouse
vim.opt.mouse = 'nvi'
-- Sync with OS clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
-- Make undo files
vim.opt.undofile = true
-- Ignore case in search
vim.opt.ignorecase = true
-- If there is a mixed case in your search, make it case-sensitive
vim.opt.smartcase = true
-- Only show sign column if needed
vim.opt.signcolumn = 'yes'
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
-- Manage NPM packages
vim.g.manage_npm = true

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

--- Highlight TODOs
vim.api.nvim_set_hl(0, "TodoHighlight", { link = "Todo" })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function()
    vim.fn.matchadd("TodoHighlight", [[\<TODO\>]])
    vim.api.nvim_set_hl(0, "TodoHighlight", { link = "Todo" })
  end,
})

vim.api.nvim_exec_autocmds("BufEnter", { buffer = 0 })

-- Install plugins if we can connect to github
require('plugins')

-- neovim lsp integration
local lazydev_ok, lazydev = pcall(require, 'lazydev')
if lazydev_ok then
  lazydev.setup()
end
vim.keymap.set('n', 'gd', vim.lsp.buf.implementation)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- lua_ls
pcall(function()
  vim.lsp.enable({ 'lua_ls' })
end)

-- rust_analyzer
pcall(function()
  vim.lsp.enable('rust_analyzer')
end)

-- pyright
pcall(function()
  vim.lsp.enable('basedpyright')
end)

-- bash
pcall(function()
  vim.lsp.enable('bashls')
end)

-- javascript
pcall(function()
local global_node_modules = vim.fn.trim(vim.fn.system('npm root -g'))
local vue_plugin_path = global_node_modules .. '/@vue/language-server'
vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  settings = {
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all" }, -- Options: "none", "literals", "all"
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
	    location = vue_plugin_path,
	    languages = { 'vue' },
	    configNamespace = 'typescript',
	    enableForWorkspaceTypescriptVersions = true
	  }
	}
	     }
	   }
  },
})
  vim.lsp.enable('vtsls')
end)

-- vue
pcall(function()
  vim.lsp.config('vue_ls', {
    filetypes = { 'vue' }
  })
  vim.lsp.enable('vue_ls')
end)

-- markdown
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function(opts)
    pcall(function()
      local render_markdown = require('render-markdown')
      render_markdown.setup({
        completions = {
          lsp = {
            enabled = true,
          },
        },
      })
      if vim.bo[opts.buf].filetype == "markdown" then
        vim.cmd("RenderMarkdown enable")
      end
    end)
  end,
})

-- json
pcall(function()
  vim.lsp.enable('jsonls')
end)

-- html
pcall(function()
  vim.lsp.enable('html')
end)

-- css
pcall(function()
  vim.lsp.enable('cssls')
end)

-- sql
pcall(function()
  vim.lsp.enable('sqlls')
end)

-- yaml
pcall(function()
  vim.lsp.enable('yamlls')
end)

-- Autocomplete
vim.o.autocomplete = true
vim.opt.complete:append('o')
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.o.pumheight = 10
vim.o.pumborder = 'rounded'vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, {autotrigger = true})
    end
  end
})

-- Inlay hints
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- Check the native capabilities table directly instead of calling a method
    if client and client.server_capabilities.inlayHintProvider then
      -- Turn them on for the current buffer
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})

-- Diagnostics
vim.o.updatetime = 300
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = '',
      scope = 'cursor'
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- Theme
pcall(function()
  local catppuccin = require('catppuccin')
  if catppuccin then
    catppuccin.setup()
    vim.cmd('colorscheme catppuccin-macchiato')
  end
end)

-- Icons
pcall(function()
  local nvim_web_devicons = require('nvim-web-devicons')
  if nvim_web_devicons then
    nvim_web_devicons.setup()
  end
end)

-- Filemanager
pcall(function()
  local nvim_tree = require('nvim-tree')
  if nvim_tree then
    nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    filters = {
      git_ignored = false,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    renderer = {
      icons = {
        web_devicons = {
          file = {
            enable = vim.g.nerd_font,
            color = true,
          },
          folder = {
            enable = vim.g.nerd_font,
            color = true,
          },
        },
        glyphs = vim.g.nerd_font and {} or {
          default = "",
          symlink = "",
          bookmark = "",
          modified = "m",
          hidden = "",
          folder = {
            arrow_closed = ">",
            arrow_open = "v",
            default = "d",
            open = "d",
            empty = "d",
            empty_open = "d",
            symlink = "ds",
            symlink_open = "ds",
          },
          git = {
            unstaged = "",
            staged = "s",
            unmerged = "",
            untracked = "",
            deleted = "d",
            ignored = "",
          },
        },
      },
    },
    })
  end
  vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<cr>', { noremap = true })
end)

-- Picker
pcall(function()
  local minipick = require('mini.pick')
  if minipick then
   	minipick.setup({
		source = {
			show = minipick.default_show,
		},
		window = {
			prompt_caret = "|",
			prompt_prefix = "> ",
		},
		show_icons = vim.g.nerd_font,
	})
	local pick_neovim_config = function()
		local picked_filename = minipick.start({
			source = {
				items = vim.fn.readdir(vim.fn.stdpath("config")),
			},
		})
		if picked_filename then
		local filename_with_path = vim.fn.stdpath("config") .. "/" .. picked_filename
		vim.cmd("edit " .. filename_with_path)
	end
	end
	-- Fuzzy find NeoVim config files
	vim.keymap.set("n", "<space>sn", pick_neovim_config, { noremap = true }) 
  end
end)
