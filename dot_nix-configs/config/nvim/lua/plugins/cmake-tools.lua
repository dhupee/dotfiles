return {
  "Civitasv/cmake-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
  lazy = true,
  ft = { "c", "cpp", "objc", "objcpp", "cmake" }, -- Lazy load on programming languages
  opts = {},
}
