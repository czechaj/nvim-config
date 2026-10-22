return {
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      auto_hide = true,
      -- Put your options here
      -- animation = true,
      -- insert_at_start = true,
      -- etc.
    },
    version = "^1.0.0",
    config = function(_, opts)
      require("barbar").setup(opts)

      local map = vim.keymap.set
      local keyopts = { noremap = true, silent = true }

      -- Previous/Next
      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", keyopts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", keyopts)

      -- Close
      map("n", "<A-c>", "<Cmd>BufferClose<CR>", keyopts)

      -- Pick buffer interactively
      map("n", "<A-p>", "<Cmd>BufferPick<CR>", keyopts)

      -- Direct buffer jump (1-9)
      for i = 1, 9 do
        map("n", ("<A-%s>"):format(i), ("<Cmd>BufferGoto %s<CR>"):format(i), keyopts)
      end

      -- Last buffer
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", keyopts)
    end,
  },
}
