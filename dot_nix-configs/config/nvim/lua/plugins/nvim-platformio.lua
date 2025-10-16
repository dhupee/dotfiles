return {
  "anurag3301/nvim-platformio.lua",
  -- "dhupee/nvim-platformio.lua",
  -- branch = "main", -- branch
  cmd = { -- comment it during development
    "Pioinit",
    "Piorun",
    "Piocmd",
    "Piolib",
    "Piomon",
  },
  dependencies = {
    { "akinsho/toggleterm.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "folke/which-key.nvim" },
  },
  config = function()
    require("platformio").setup({
      lsp = "clangd",
    })
  end,
}
