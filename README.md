# Shared AstroNvim v5 configuration

Merged from **nvim-win10.zip** and **nvim-win11.zip**. Run the same configuration on both machines, and make fixes centrally in Git.

## Selected baseline

- Windows 10: active save behavior (`lua/polish.lua`), `.env.*` filetype detection, LuaRocks disabled, semantic-token API fix.
- Windows 11: session restore, Diffview, render-markdown, fuller Treesitter parser list.
- Only Windows machines with `gcc` in PATH use it for Treesitter builds. Parser binaries are **not** shared.
- `lazy-lock.json` keeps Windows 10 pins for existing plugins and adds the Windows 11-only plugin pins.

## Before replacing anything

Back up `%LOCALAPPDATA%\nvim` on each device. Extract this archive into a *new* directory first. Do not unzip over an existing configuration until satisfied with the comparison.

## Git setup (PowerShell, from extracted folder)

```powershell
git init
git branch -M main
git add .
git commit -m "chore: unify AstroNvim v5 across Windows 10 and 11"
git remote add origin https://github.com/YOUR_USERNAME/nvim-config.git
git push -u origin main
```

Install on Windows from a backed-up configuration:

```powershell
Rename-Item "$env:LOCALAPPDATA\nvim" "nvim.backup"
git clone https://github.com/YOUR_USERNAME/nvim-config.git "$env:LOCALAPPDATA\nvim"
nvim
```

Run `:Lazy sync`, then restart Neovim. Avoid `:Lazy update` unless intentionally upgrading plugin versions.

## Verification

- Open a `.env.local` and run `:set filetype?`; expect `sh`.
- Open TSX and run `:LspInfo`; expect vtsls + eslint (as appropriate).
- Check `:autocmd CustomTypeScriptSave` and save TSX containing an unused import.
- Verify Prettier formatting and ESLint fixes separately.
- On Windows 11, verify `:DiffviewOpen`, Markdown rendering, and session restoration.

## Follow-ups (not silently modified)

1. Format-on-save ordering: AstroLSP's separate formatting handler and custom import/ESLint actions can race. Tested basic behavior on Windows 10, but strict ordering remains unverified.
2. `telescope.lua` calls `load_extension "file_browser"` without an explicit file-browser dependency; validate/fix separately.
3. Auto-restore of cwd sessions, imported from Windows 11, may restore a session unexpectedly. Remove `lua/plugins/auto_restore_sessions.lua` if not desired.
4. Both systems should use a compatible AstroNvim v5/Neovim version. `:Lazy sync` installs plugin pins; compiler/tool installations remain machine-local.

`lua/config/platform.lua` exposes `is_windows`, `is_win10`, `is_win11`, etc., for *future* platform-specific fixes. Avoid branching by OS unless necessary.
