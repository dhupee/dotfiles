return {
  -- "anurag3301/nvim-platformio.lua",
  "dhupee/nvim-platformio.lua",
  branch = "main", -- branch
  cmd = { -- comment it during development
    "Pioinit",
    "Piorun",
    "Piocmd",
    "Piolib",
    "Piomon",
    "Piodb",
    "Piocmdh",
    "Piocmdf",
    "Piodebug",
    "PioTermList",
  },
  dependencies = {
    { "akinsho/toggleterm.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "folke/which-key.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("platformio").setup({
      lsp = "clangd",
      clangd_source = "compiledb",
    })
  end,
}
