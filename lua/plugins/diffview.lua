---@type LazySpec
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>gv", "<Cmd>DiffviewOpen<CR>", desc = "Git: Review changes" },
    { "<Leader>gH", "<Cmd>DiffviewFileHistory %<CR>", desc = "Git: Current file history" },
    { "<Leader>gV", "<Cmd>DiffviewClose<CR>", desc = "Git: Close diff view" },
  },
  opts = {
    enhanced_diff_hl = true,
    file_panel = { listing_style = "tree", win_config = { position = "left", width = 32 } },
  },
}
