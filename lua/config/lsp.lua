require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
})

local lspconfig = require("lspconfig")

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- checkThirdParty=false avoids the "Do you want to configure?" prompt
        -- and prevents loading thousands of runtime files (which causes slowness)
        checkThirdParty = false,
        library = { vim.fn.stdpath("data") .. "/lazy/lazy.nvim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- # disable status bar
vim.lsp.handlers["$/progress"] = function() end
