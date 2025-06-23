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
    { "akinsho/nvim-toggleterm.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
}
