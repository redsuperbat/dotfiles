---@module "lazy"
---@type LazySpec
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { "lsp", "treesitter" } },
    })
  end,
}
