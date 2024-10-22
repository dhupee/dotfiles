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
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      tools = {
        language_server = "/nix/store/qbwpqkjc6a0szxjwdwmhkcvzwhrax3yk-codeium-1.20.9/bin/codeium_language_server",
      },
    })
  end,
}
