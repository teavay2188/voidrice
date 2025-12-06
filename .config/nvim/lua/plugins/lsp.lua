return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Installer and Bridge
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Auto-completion Engine
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- Snippet Engine
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 1. Setup Mason (LSP Installer)
      mason.setup()
      mason_lspconfig.setup({
        -- Ensure these LSP servers are installed the first time Neovim runs.
        ensure_installed = {
          "clangd",           -- C/C++
          "pylsp",            -- Python (Recommended general purpose Python LSP)
          "julials",          -- Julia
          "svls",             -- SystemVerilog
          "lua_ls",           -- Neovim config self-support
        },
      }) 

      -- 2. Define Shared LSP Capabilities and Handlers
      -- This gives the LSP client (Neovim) the full capabilities, especially for snippets.
      local capabilities = vim.lsp.protocol.get_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        -- Disable autoformat from server (we'll use a dedicated formatter plugin later)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        
        -- Keybindings for LSP features (customize as needed)
        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
        -- Add more mappings here...
      end

      -- 3. Configure LSP Servers with Mason-LSPConfig
      -- This function runs for every server installed by Mason.
      mason_lspconfig.setup_handlers({
        -- Default handler: applies common settings to all LSPs
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            -- Add common settings here
          })
        end,

        -- Specific Configuration Overrides (Optional but recommended)

        -- C/C++ (clangd)
        ["clangd"] = function()
          lspconfig.clangd.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            -- Add specific clangd settings if needed
          })
        end,

        -- SystemVerilog (svls)
        ["svls"] = function()
          lspconfig.svls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            -- svls might need specific root_dir or settings for large projects.
            -- Check documentation for project-specific settings.
          })
        end,

        -- Julia (julials)
        -- julials typically requires very little extra config.
        -- It uses the default handler but you can override here if necessary.
      })
      
      -- 4. Setup nvim-cmp (Completion)
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
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
          { name = "nvim_lsp" },  -- Completion from Language Servers
          { name = "luasnip" },   -- Completion from snippets
          { name = "buffer" },    -- Completion from current buffer words
          { name = "path" },      -- Completion from file paths
        }),
      })

      -- Set up command line completion
      cmp.setup.cmdline("/", {
        sources = cmp.config.sources({ { name = "buffer" } }),
      })

      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({ { name = "cmdline" } }),
      })
    end,
  },
}
