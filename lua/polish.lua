local function setup()
  vim.opt.clipboard = "unnamedplus"

  local group = vim.api.nvim_create_augroup("CustomTypeScriptSave", {
    clear = true,
  })

  local function apply_actions(bufnr, client, kind)
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = {
      only = { kind },
      diagnostics = {},
    }

    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)

    if not results then return end

    local response = results[client.id]
    if not response then return end

    for _, action in ipairs(response.result or {}) do
      if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding) end

      if action.command then client:exec_cmd(action.command, { bufnr = bufnr }) end
    end
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = { "*.ts", "*.tsx" },
    callback = function(args)
      local bufnr = args.buf

      if vim.bo[bufnr].buftype ~= "" then return end

      local clients = vim.lsp.get_clients { bufnr = bufnr }

      for _, client in ipairs(clients) do
        if client.name == "vtsls" then
          apply_actions(bufnr, client, "source.removeUnused.ts")
          apply_actions(bufnr, client, "source.organizeImports.ts")
        elseif client.name == "eslint" then
          apply_actions(bufnr, client, "source.fixAll.eslint")
        end
      end
    end,
  })

  -- Persist selected colorscheme across restarts
  local theme_file = vim.fn.stdpath "data" .. "/selected-theme.txt"

  if vim.fn.filereadable(theme_file) == 1 then
    local saved = vim.fn.readfile(theme_file)

    if saved[1] and saved[1] ~= "" then pcall(vim.cmd.colorscheme, saved[1]) end
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("PersistentColorscheme", {
      clear = true,
    }),
    callback = function(args)
      if args.match and args.match ~= "" then vim.fn.writefile({ args.match }, theme_file) end
    end,
  })
end

setup()
