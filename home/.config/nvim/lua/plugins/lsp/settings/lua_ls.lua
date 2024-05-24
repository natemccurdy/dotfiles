local opts = {
  format = {
    enable = true,
  },
  diagnostics = { globals = { "vim" } }, -- TODO: "`vim` is not defined" is being thrown in lua neovim config files.
  telemetry = { enable = false },
  hint = { enable = true },
}

return opts
