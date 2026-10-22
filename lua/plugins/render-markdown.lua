---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  name = "render-markdown",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t" },
    heading = { enabled = true, sign = false },
    code = { enabled = true, sign = false, style = "full" },
    pipe_table = { enabled = true },
    checkbox = { enabled = true },
  },
}
