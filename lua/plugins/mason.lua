-- lua/plugins/mason.lua
-- Customize Mason

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSPs you want available
        "lua-language-server",
        "vtsls",
        "eslint-lsp",
        "tailwindcss-language-server",

        -- formatters
        "stylua",

        -- debuggers
        "debugpy",

        -- other
        "tree-sitter-cli",
      },
      run_on_start = true,
      start_delay = 3000,
    },
  },
}
