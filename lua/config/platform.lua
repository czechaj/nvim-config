local M = {}
M.is_windows = vim.fn.has "win32" == 1
M.is_linux = vim.fn.has "linux" == 1
M.is_macos = vim.fn.has "mac" == 1
M.windows_build = nil
M.is_win10 = false
M.is_win11 = false

-- Query only on Windows. OS detection is informational unless a setting needs it.
if M.is_windows then
  local output = vim.fn.system {
    "powershell.exe", "-NoProfile", "-NonInteractive", "-Command",
    "[System.Environment]::OSVersion.Version.Build",
  }
  local build = tonumber(vim.trim(output))
  M.windows_build = build
  M.is_win10 = build ~= nil and build < 22000
  M.is_win11 = build ~= nil and build >= 22000
end

return M
