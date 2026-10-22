-- AppData/Local/nvim/lua/plugins/logsitter.lua
return {
  "gaelph/logsitter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = { -- optional; defaults shown in README
    path_format = "fileonly",
    prefix = "🚀",
    separator = "->",
  },
  init = function()
    -- add buffer-local mappings when editing supported langs
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "astro",
        "svelte",
        "lua",
        "go",
        "python",
        "swift",
      },
      callback = function(ev)
        local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc }) end
        map("n", "<leader>lg", function() require("logsitter").log() end, "Logsitter: insert log")
        map("x", "<leader>lg", function() require("logsitter").log_visual() end, "Logsitter: log selection")
      end,
    })
  end,
}
