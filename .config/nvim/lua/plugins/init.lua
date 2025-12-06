return {
  -- Example Plugin: The popular color scheme "tokyonight"
  { "folke/tokyonight.nvim", priority = 1000 },

  -- Import all the feature-specific plugin configurations
  require("plugins.editor"),
  require("plugins.git"),
  --require("plugins.julia"),
  require("plugins.lsp"),
  require("plugins.notes"),
  --require("plugins.verilog"),
}
