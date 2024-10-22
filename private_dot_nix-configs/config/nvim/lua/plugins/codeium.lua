return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    enable_chat = true,
    wrapper = "~/.scripts/srghma-codeium-nix-wrapper",
  },
}
