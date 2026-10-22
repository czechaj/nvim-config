---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}

      opts.keymap["<C-Space>"] = {
        function(cmp)
          cmp.show {
            providers = { "lsp" },
          }
        end,
      }

      return opts
    end,
  },
}
