---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = {
    sessions = {
      autosave = { last = true, cwd = true },
    },
    autocmds = {
      restore_directory_session = {
        {
          event = "VimEnter",
          desc = "Restore directory session when Neovim starts without file arguments",
          nested = true,
          callback = function()
            if vim.fn.argc(-1) ~= 0 then return end
            require("resession").load(vim.fn.getcwd(), {
              dir = "dirsession",
              silence_errors = true,
            })
          end,
        },
      },
    },
  },
}
