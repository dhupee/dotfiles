return {
  -- "Exafunction/codeium.nvim",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "hrsh7th/nvim-cmp",
  -- },
  -- opts = {
  --   enable_chat = true,
  --   wrapper = "$HOME/.scripts/srghma-codeium-nix-wrapper",
  -- },
  "Exafunction/codeium.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
  end,
}
