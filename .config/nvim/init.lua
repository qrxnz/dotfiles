require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use 'folke/tokyonight.nvim'
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/nvim-cmp"
	use "jose-elias-alvarez/null-ls.nvim"
	use "kyazdani42/nvim-web-devicons"
	use "L3MON4D3/LuaSnip"
	use "lewis6991/gitsigns.nvim"
	use "neovim/nvim-lspconfig"
	use "nvim-lua/plenary.nvim"
	use "nvim-lualine/lualine.nvim"
	use "nvim-telescope/telescope.nvim"
	use "nvim-telescope/telescope-file-browser.nvim"
	use "nvim-treesitter/nvim-treesitter"
	use "onsails/lspkind-nvim"
	use "ryanoasis/vim-devicons"
	use "saadparwaiz1/cmp_luasnip"
	use "simrat39/rust-tools.nvim"
	use "tpope/vim-commentary"
	use "williamboman/nvim-lsp-installer"
	use "windwp/nvim-autopairs"
	use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
end)

-- basics
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.nu = true

-- tokyonight theme
vim.cmd[[colorscheme tokyonight]]
vim.g.tokyonight_style = "night"

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

local lang_maps = {
	cpp = { build = "g++ % -o %:r", exec = "./%:r" },
	typescript = { build = "deno compile %", exec = "deno run %" },
	javascript = { build = "deno compile %", exec = "deno run %" },
	python = { exec = "python %" },
	java = { build = "javac %", exec = "java %:r" },
	sh = { exec = "./%" },
	go = { build = "go build", exec = "go run %" },
	rust = { exec = "cargo run" },
	arduino = {
		build = "arduino-cli compile --fqbn arduino:avr:uno %:r",
		exec = "arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno %:r",
	},
}
for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{ command = "nnoremap <Leader>b :!" .. data.build .. "<CR>", pattern = lang }
		)
	end
	vim.api.nvim_create_autocmd(
		"FileType",
		{ command = "nnoremap <Leader>e :split<CR>:terminal " .. data.exec .. "<CR>", pattern = lang }
	)
end
vim.api.nvim_create_autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
	pattern = "*.cpp,*.css,*.go,*.h,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml",
})


local luasnip = require "luasnip"
local cmp = require "cmp"
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
}

local servers = {
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"pyright",
	"rust_analyzer",
	"sumneko_lua",
	"tailwindcss",
	"tsserver",
}
local has_formatter = { "gopls", "html", "rust_analyzer", "sumneko_lua", "tsserver" }
for _, name in pairs(servers) do
	local found, server = require("nvim-lsp-installer").get_server(name)
	if found and not server:is_installed() then
		server:install()
	end
end
local setup_server = {
	sumneko_lua = function(opts)
		opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end,
}
require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			local opts = { buffer = bufnr }
			vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<Leader>i", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
			local should_format = true
			for _, value in pairs(has_formatter) do
				if client.name == value then
					should_format = false
				end
			end
			if not should_format then
				client.resolved_capabilities.document_formatting = false
			end
		end,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
	if setup_server[server.name] then
		setup_server[server.name](opts)
	end
	server:setup(opts)
end)

local null_ls = require "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
	},
}

require("gitsigns").setup {
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
}

local telescope = require "telescope"
telescope.setup {
	defaults = {
		mappings = { n = { ["o"] = require("telescope.actions").select_default } },
		initial_mode = "normal",
		hidden = true,
		file_ignore_patterns = { ".git/", "node_modules/", "target/" },
	},
	extensions = { file_browser = { hidden = true } },
}
telescope.load_extension "file_browser"
vim.keymap.set("n", "<Leader>n", telescope.extensions.file_browser.file_browser)
vim.keymap.set("n", "<Leader>f", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter)

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"bash",
		"cpp",
		"css",
		"go",
		"html",
		"lua",
		"make",
		"python",
		"rust",
		"tsx",
		"typescript",
		"yaml",
	},
	highlight = { enable = true },
}

require("rust-tools").setup {}

vim.keymap.set({ "n", "v" }, "<Leader>c", ":Commentary<CR>", { silent = true })

require("nvim-autopairs").setup {}

require("lsp_lines").setup {}
vim.keymap.set("n", "<Leader>x", require("lsp_lines").toggle)