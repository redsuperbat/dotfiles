---@module "lazy"
---@type LazySpec
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp", "treesitter" },
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
