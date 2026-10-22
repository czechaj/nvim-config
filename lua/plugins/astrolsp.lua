-- Next.js-friendly LSP: vtsls + eslint, and disable tsserver/ts_ls

---@type LazySpec
return {
  -- 1) LSP configuration
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      features = {
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
      },

      -- Let ESLint/Prettier own formatting
      formatting = {
        format_on_save = {
          enabled = true,
          allow_filetypes = {},
          ignore_filetypes = {},
        },
        disabled = { "vtsls" }, -- disable only the formatter of vtsls
        timeout_ms = 1000,
      },

      -- Do NOT list ts_ls here. We only want vtsls + eslint
      servers = {
        "vtsls",
        "eslint",
      },

      ---@diagnostic disable: missing-fields
      config = {
        vtsls = {
          init_options = {
            hostInfo = "neovim",
            tsserver = {
              watchOptions = {
                watchFile = "dynamicPriorityPolling",
                watchDirectory = "dynamicPriorityPolling",
              },
            },
          },
          settings = {
            vtsls = { autoUseWorkspaceTsdk = true },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
              inlayHints = { includeInlayParameterNameHints = "all" },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
              inlayHints = { includeInlayParameterNameHints = "all" },
            },
          },
          on_attach = function(client, _)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      },

      -- 🔒 Hard-disable tsserver/ts_ls if something tries to set them up
      handlers = {
        tsserver = false,
        ts_ls = false,
      },

      autocmds = {
        lsp_codelens_refresh = {
          cond = "textDocument/codeLens",
          {
            event = { "InsertLeave", "BufEnter" },
            desc = "Refresh codelens (buffer)",
            callback = function(args)
              if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
            end,
          },
        },
      },

      mappings = {
        n = {
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
          ["<Leader>uY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
        },
      },

      -- ESLint: Fix All on save
      -- on_attach = function(client, bufnr)
      --   if client.name == "eslint" then
      --     local grp = vim.api.nvim_create_augroup("EslintFixAllOnSave", { clear = false })
      --     vim.api.nvim_clear_autocmds { group = grp, buffer = bufnr }
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = grp,
      --       buffer = bufnr,
      --       desc = "ESLint: Fix All on save",
      --       callback = function()
      --         vim.lsp.buf.code_action {
      --           context = { only = { "source.fixAll.eslint" } },
      --           apply = true,
      --         }
      --       end,
      --     })
      --   end
      -- end,
    },
  },

  -- 2) Mason: ensure vtsls & eslint are installed (and stop auto-installing tsserver/ts_ls)
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- add
      for _, name in ipairs { "vtsls", "eslint" } do
        if not vim.tbl_contains(opts.ensure_installed, name) then table.insert(opts.ensure_installed, name) end
      end
      -- remove if present
      for _, name in ipairs { "tsserver", "ts_ls" } do
        for i = #opts.ensure_installed, 1, -1 do
          if opts.ensure_installed[i] == name then table.remove(opts.ensure_installed, i) end
        end
      end
    end,
  },
}
