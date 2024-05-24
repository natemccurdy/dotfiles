local M = {}

local utils = require("utils.functions")

local health = vim.health
local _ok = health.ok
local _warn = health.warn
local _error = health.error

local programs = {
  go = {
    required = false,
    desc = "some Go related features might not work",
  },
  node = {
    required = false,
    desc = "Mason will not be able to install some LSPs/tools",
  },
  cargo = {
    required = false,
    desc = "some Rust related features might not work and tools that are built by cargo cannot be installed",
  },
  rg = {
    required = true,
    desc = "a highly recommended grep alternative (ripgrep is the package name)",
  },
  fd = {
    required = true,
    desc = "a highly recommended find alternative",
  },
}

local exec_not_found_template = "'%s' executable not found - %s"
local exec_found_template = "'%s' executable found"

M.check = function()
  vim.health.start("System configuration")
  local os = utils.getOS()

  if not utils.isNeovimVersionsatisfied(10) then
    _warn("This config probably won't work very well with Neovim < 0.10")
  else
    _ok("This config will work with your Neovim version")
  end

  if os == "NixOS" then
    _warn("This config downloads and runs binaries which might cause an issue on NixOS")
  elseif os == "" then
    _warn("Could not determine OS; Only Linux, Darwin, and NixOS is supported; It might work though")
  else
    _ok("Running on supported OS: " .. os)
  end

  if next(utils.load_user_config()) == nil then
    _warn("No or wrong (check :messages) user configuration provided (this is optional)")
  else
    _ok("User configuration found")
  end

  for k, v in pairs(programs) do
    if not utils.isExecutableAvailable(k) then
      if v.required then
        _error(string.format(exec_not_found_template, k, v.desc))
      else
        _warn(string.format(exec_not_found_template, k, v.desc))
      end
    else
      _ok(string.format(exec_found_template, k))
    end
  end

  if not utils.isExecutableAvailable("python") then
    if not utils.isExecutableAvailable("python3") then
      _warn("Python was not found - some Python related features might not work")
    end
  end
end

return M
