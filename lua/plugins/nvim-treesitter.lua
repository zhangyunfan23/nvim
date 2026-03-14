return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "python",
      "lua",
      "html",
      "javascript",
      "typescript",
      "bash",
      "json",
      "yaml",
      "markdown",
    },
  },
}
