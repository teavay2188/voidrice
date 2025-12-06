return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          -- ... your icon definitions here ...
          Up = '<Up> ',
          -- ...
          F12 = '<F12>',
        },
      },
    },
    -- This 'config' function is crucial for which-key, as it initializes it.
    config = function(_, opts)
      require("which-key").setup(opts)
    end
  },
  {
	  'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
	  dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	branch = 'main',
	build = ':TSUpdate'
  },
  {
	  'stevearc/conform.nvim',
	  opts = {},
  }
}
