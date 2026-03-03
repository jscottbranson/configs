-- =============================================================================
-- init.lua - Neovim 0.11+ config for Python3 / Django / HTML / CSS
-- Place at: ~/.config/nvim/init.lua
-- After first launch: :MasonInstall pyright html-lsp css-lsp debugpy
-- =============================================================================

-- Leader (optional but recommended)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- termguicolors must be set before any plugin that depends on it (e.g. colorizer)
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
-- FIX: vim.loop is deprecated in 0.11+, replaced with vim.uv
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "nvim-lua/plenary.nvim", lazy = true },

  -- LSP
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Linting
  { "dense-analysis/ale" },

  -- Python / Django
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python" },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("venv-selector").setup() end,
  },

  -- HTML / CSS / Templates
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  { "mattn/emmet-vim" },
  {
    "NvChad/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "python", "html", "css", "javascript", "jinja", "typescript", "tsx" },
        highlight        = { enable = true },
        indent           = { enable = true },
        autotag          = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Navigation / QoL
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",           desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",            desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",              desc = "Buffers" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "LSP symbols" },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" } },
    config = function() require("nvim-tree").setup() end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("lualine").setup({ options = { theme = "auto" } }) end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
  },
  { "tpope/vim-fugitive" },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require("ibl").setup() end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end,
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },

  -- Colorschemes
  { "folke/tokyonight.nvim", priority = 1000 },

})

-- =============================================================================
-- Mason + LSP  (Neovim 0.11 native API)
-- =============================================================================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "html", "cssls" },
})

vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- =============================================================================
-- LSP keymaps
-- =============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local o = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,   o)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,        o)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,   o)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,       o)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,  o)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev, o)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next, o)
  end,
})

-- =============================================================================
-- Completion (nvim-cmp)
-- =============================================================================
local cmp     = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<Tab>"]     = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip"  },
    { name = "buffer"   },
    { name = "path"     },
  }),
})

-- =============================================================================
-- ALE / venv
-- =============================================================================
vim.g.ale_linters = { python = { "pylint" } }
-- Optional: avoid ALE duplicating LSP diagnostics
-- vim.g.ale_disable_lsp = 1

vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select venv" })

-- =============================================================================
-- General Settings
-- =============================================================================
local opt = vim.opt

-- NOTE: termguicolors is already set at the top of this file
opt.background     = "dark"
opt.number         = true
opt.relativenumber = true
opt.showmatch      = true
opt.cmdheight      = 2
opt.wildmenu       = true

vim.cmd("colorscheme tokyonight") -- swap to "southernlights" if preferred

opt.spell = true
vim.cmd("hi clear SpellBad")
vim.cmd("hi SpellBad cterm=underline,bold ctermfg=red")

opt.wrapscan   = true
opt.hlsearch   = true
opt.incsearch  = true
opt.ignorecase = true
opt.smartcase  = true
opt.infercase  = true

opt.linebreak  = true
opt.autoindent = true
opt.copyindent = true
opt.shiftwidth = 4
opt.tabstop    = 4

opt.foldmethod = "expr"
opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel  = 99
vim.keymap.set("n", "<space>", "za", { noremap = true, silent = true })

-- =============================================================================
-- File Type Overrides
-- =============================================================================
local augroup = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group    = augroup,
  pattern  = { "html", "css", "htmldjango" },
  callback = function()
    vim.opt_local.tabstop     = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.textwidth   = 80
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group    = augroup,
  pattern  = { "python" },
  callback = function()
    vim.opt_local.tabstop     = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth  = 4
    vim.opt_local.textwidth   = 80
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group    = augroup,
  pattern  = { "r", "rmd" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- To run R outside nvim's terminal emulator, uncomment and complete:
-- vim.g.R_in_buffer = 0
