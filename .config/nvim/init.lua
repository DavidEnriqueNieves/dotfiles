-- Old vim keybindings
vim.cmd("source ~/.vimrc")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({

  -- General
  { "tpope/vim-surround" },
  { "preservim/nerdcommenter" },
  { "SirVer/ultisnips" },
  { "preservim/nerdtree" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
        }
      })
    end
  },

  -- ToggleTerm
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "vertical",
      size = 80,
      open_mapping = nil, -- disable default mapping
      persist_mode = true,
      persist_size = true,
      close_on_exit = false,
      shade_terminals = false,
    })

    -- Create a persistent terminal instance
    local Terminal = require("toggleterm.terminal").Terminal

    local vertical_term = Terminal:new({
      direction = "vertical",
      hidden = true,   -- important for persistence
    })

    -- Keymap
    vim.keymap.set("n", "<leader>tt", function()
      vertical_term:toggle()
    end, { desc = "Toggle vertical terminal" })

    vim.keymap.set("t", "<leader>tt", function()
      vertical_term:toggle()
    end, { desc = "Toggle vertical terminal" })

    vim.keymap.set("v", "<C-[>", function()
      local file = vim.fn.expand("%:p")
      local start_line = vim.fn.line("'<")
      local end_line = vim.fn.line("'>")
    
      local input = string.format("%s:%d:%d", file, start_line, end_line)
    
      vertical_term:open()
    
      -- Jump directly to terminal buffer
      vim.api.nvim_set_current_buf(vertical_term.bufnr)
    
      vertical_term:send(input .. "\n", true)
    
      vim.cmd("startinsert!")
    end)

  end,
},
  { 
    "nvim-telescope/telescope.nvim", 
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  { "windwp/nvim-autopairs", config = true },

  { "ryanoasis/vim-devicons" },

  -- Markdown
  { 
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install"
  },

  { "preservim/vim-markdown" },
  { "ferrine/md-img-paste.vim" },
  { "vimwiki/vimwiki" },
  -- LaTeX
  { "lervag/vimtex" },

{
  "neovim/nvim-lspconfig",
  dependencies = {
    -- LSP installer (recommended)
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim" },

    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
  },

  config = function()
    -- =====================
    -- Mason (installs servers)
    -- =====================
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright" },
    })

    -- =====================
    -- Completion setup
    -- =====================
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
    })

    -- =====================
    -- LSP setup (NEW API)
    -- =====================
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

    vim.lsp.enable("pyright")
  end
}

})


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end,
})

---------------------------------------
--       Filetype Settings
---------------------------------------


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tex",
  callback = function()
    vim.bo.filetype = "tex"
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.md",
  callback = function()
    vim.bo.syntax = "markdown"
  end,
})

---------------------------------------
--       Global PluginSettings
---------------------------------------


vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_math = 1

vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0

vim.g["airline#extensions#tabline#enabled"] = 1

-- critical fix: prevents vimwiki from hijacking markdown
vim.g.vimwiki_global_ext = 0

---------------------------------------
--       Telescope
---------------------------------------

local keymap = vim.keymap.set
local builtin = require("telescope.builtin")

keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
keymap("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden", -- include hidden files
  	"--glob", "!.git/*",
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob",
        "!.git/*", -- exclude .git
      },
    },
  },
})


---------------------------------------
--       Airline
---------------------------------------

-- Theme / colors
vim.opt.background = "light"
-- vim.cmd("colorscheme one")

-- Airline settings (vimscript globals)
vim.g.airline_theme = "one"
vim.g.airline_powerline_fonts = 1

-- Theme-specific option
vim.g.one_allow_italics = 1

-- Temp directory
vim.opt.directory:prepend(vim.fn.expand("$HOME/.vim/tmp"))

---------------------------------------
--       Markdown Image Paste
---------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>p",
      "<cmd>call mdip#MarkdownClipboardImage()<cr>",
      { buffer = true, silent = true }
    )
  end,
})

---------------------------------------
--       Vimwiki
---------------------------------------

vim.api.nvim_create_augroup("VimwikiTabFix", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "VimwikiTabFix",
  pattern = "vimwiki",
  callback = function()
    vim.keymap.set("n", "<Tab>", "<Nop>", { buffer = true })
    vim.keymap.set("n", "<S-Tab>", "<Nop>", { buffer = true })
    vim.keymap.set("i", "<Tab>", "<Nop>", { buffer = true })
    vim.keymap.set("i", "<S-Tab>", "<Nop>", { buffer = true })
  end,
})

vim.g.vimwiki_list = {
  { path = "~/vimwiki/", syntax = "markdown", ext = ".md" },
  { path = "/home/davidn/Documents/Notes/", syntax = "markdown", ext = ".md" },
}


local function VimwikiNewArticleFromArg(article_title)
  local article = article_title:gsub(" ", "_")

  local dir_pth = article .. "/" .. article .. ".md"
  local pth = "./" .. dir_pth
  local glob_dir = vim.fn.expand("%:p:h") .. "/" .. article

  local link = "[" .. article_title .. "](" .. pth .. ")"

  -- replace current line
  vim.api.nvim_set_current_line(link)

  -- create directory
  local ok = vim.fn.mkdir(glob_dir, "p")
  if ok == 0 then
    vim.notify("Failed to create directory: " .. glob_dir, vim.log.levels.ERROR)
  end

  -- save file
  vim.cmd("write")

  -- follow wiki link
  vim.cmd("VimwikiFollowLink")

  -- timestamp
  local creat_time = os.date("%Y-%m-%d %a %I:%M %p")

  -- rewrite page
  vim.api.nvim_set_current_line("# " .. article_title)
  vim.cmd("normal! o")
  vim.cmd("normal! o")
  vim.api.nvim_set_current_line("Created: " .. creat_time)

  vim.cmd("normal! o")
  vim.cmd("startinsert")
end


local function VimwikiNewArticleAskName()
  local article_title = vim.fn.input("Article name: ")

  if article_title == "" then
    vim.notify("No article name provided.")
    return
  end

  VimwikiNewArticleFromArg(article_title)
end

local function VimwikiNewWeeklyArticle()
  local title = GetWeekNotesTitle()
  VimwikiNewArticleFromArg(title)
end

vim.keymap.set("n", "<leader>wk", VimwikiNewWeeklyArticle)
vim.keymap.set("n", "<leader>wa", VimwikiNewArticleAskName)

---------------------------------------
--       Markdown Preview
---------------------------------------

vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = "8765"


---------------------------------------
--       Ultisnips
---------------------------------------

vim.g.UltiSnipsSnippetDirectories = { "mysnippets" }
vim.g.UltiSnipsSnippetsDir = "mysnippets"

vim.g.UltiSnipsExpandTrigger = "<Tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.g.UltiSnipsSnippetDirectories = { "mysnippets" }
  end,
})

---------------------------------------
--       Vim LSP
---------------------------------------

local cmp = require("cmp")

vim.keymap.set("i", "<Tab>", function()
  if cmp.visible() then
    cmp.confirm({ select = true })
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { silent = true })

vim.keymap.set("i", "<M-j>", function()
  if cmp.visible() then
    cmp.select_next_item()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-j>", true, false, true), "n", false)
  end
end, { silent = true })

vim.keymap.set("i", "<M-k>", function()
  if cmp.visible() then
    cmp.select_prev_item()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-k>", true, false, true), "n", false)
  end
end, { silent = true })




vim.keymap.set("n", "<leader>to", function()
  print("TOGGLE HIT")
  opencode:toggle()
end, { silent = false })
