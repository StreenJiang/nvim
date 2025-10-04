-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Determine OS
local system_os
if vim.fn.has("mac") == 1 then
  system_os = "mac"
elseif vim.fn.has("unix") == 1 then
  system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  system_os = "win"
  vim.opt.shellslash = false -- Enable shellslash for Windows compatibility
  vim.defer_fn(function()
    vim.opt.shellslash = false
  end, 5000)
else
  print("OS not found, defaulting to 'linux'")
  system_os = "linux"
end

print("Using system os: " .. system_os)

-- Encoding
vim.scriptencoding = "utf-8"
vim.g.encoding = "utf-8"
vim.g.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.have_nerd_font = true

-- Opts
local opt = vim.opt

-- tab indent
opt.tabstop = 4
vim.g.tabstop = 4
opt.expandtab = true
opt.autoindent = true
