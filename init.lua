-- bootstrap lazy.nvim, LazyVim and your plugins
local is_vscode = vim.g.vscode ~= nil

if is_vscode then
  require("config.vscode")
else
  require("config.options")
  require("config.lazy")
  require("config.lsp")
  require("config.keymaps")
end
