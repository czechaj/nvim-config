---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}

    for _, lang in ipairs {
      "lua", "vim", "vimdoc", "query", "bash", "c", "markdown", "markdown_inline",
      "javascript", "typescript", "tsx", "json", "css", "html",
    } do
      if not vim.tbl_contains(opts.ensure_installed, lang) then
        table.insert(opts.ensure_installed, lang)
      end
    end

    -- Windows 11 explicitly used native GCC; use it only where available.
    -- Both Windows versions can share this setting; parser builds stay machine-local.
    if require("config.platform").is_windows and vim.fn.executable("gcc") == 1 then
      require("nvim-treesitter.install").compilers = { "gcc" }
    end
  end,
}
