return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "hard",
      transparent_mode = false,
      dim_inactive = true,
      inverse = true,
      invert_selection = false,
      italic = {
        strings = false,
        comments = true,
        emphasis = true,
        operators = false,
        folds = true,
      },
      bold = true,
      overrides = {
        SignColumn = { bg = "NONE" },
        CursorLineNr = { fg = "#fabd2f", bold = true },
        Visual = { bg = "#504945" },
      },
    },
  },
}
