return {
  cmd = { "/Users/maxnetterberg/Projects/rustproof/target/debug/rustproof" },
  name = "rustproof",
  filetypes = { "rust", "lua", "ruby", "javascript", "toml" },
  root_dir = vim.fn.getcwd(),
  trace = "verbose",
  init_options = {
    dict_path = "~/.config/nvim/lua/max/plugins/lsp/rustproof/dict.txt",
  },
}
