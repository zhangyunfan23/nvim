return {
  {
    "hrsh7th/cmp-cmdline",
    dependences = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/nvim-cmp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<CR>"] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
