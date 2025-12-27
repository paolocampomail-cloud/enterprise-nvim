-- ============================================================================
-- LSP Configuration - Rust (rustaceanvim) and Assembly - Neovim 0.11+
-- ============================================================================

return {
  -- Mason - LSP installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "lua_ls",
          "asm_lsp",
        },
        automatic_installation = true,
      })
    end,
  },

  -- Core LSP config (new vim.lsp.config API; no require('lspconfig').setup)
  {
    "neovim/nvim-lspconfig", -- keep for defaults; we don't call its deprecated API
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostics (no :sign define; uses new API)
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.HINT]  = "󰌵",
            [vim.diagnostic.severity.INFO]  = "",
          },
        },
        virtual_text = { prefix = "●", source = "if_many" },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- on_attach with safe doc highlights
      local on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        if client.server_capabilities.documentHighlightProvider then
          local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                pcall(vim.lsp.buf.document_highlight)
              end
            end,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = bufnr,
            callback = function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                pcall(vim.lsp.buf.clear_references)
              end
            end,
          })
        end
      end

      -- Server configs (new API)
      local servers = {
        rust_analyzer = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            ["rust-analyzer"] = {
              assist = { importGranularity = "module", importPrefix = "by_self" },
              cargo = { loadOutDirsFromCheck = true, allFeatures = true },
              procMacro = { enable = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--all", "--", "-W", "clippy::all" },
              },
              diagnostics = { enable = true, experimental = { enable = true } },
              hover = { actions = { enable = true } },
              inlayHints = {
                enable = true,
                chainingHints = true,
                maxLength = 25,
                parameterHints = true,
                typeHints = true,
              },
              lens = { enable = true },
            },
          },
        },

        asm_lsp = {
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { "asm", "nasm", "s", "S" },
          cmd = { "asm-lsp" },
        },

        lua_ls = {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end
    end,
  },

  -- Rust (rustaceanvim) — replaces rust-tools to avoid lspconfig deprecation
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- current stable major
    ft = { "rust" },
    init = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = { border = "rounded" },
        },
        server = {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              procMacro = { enable = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
        popup = { border = "rounded" },
      })
    end,
  },
}
