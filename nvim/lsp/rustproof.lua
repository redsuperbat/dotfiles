return {
  cmd = { "rustproof" },
  name = "rustproof",
  filetypes = {
    "rust",
    "lua",
    "ruby",
    "javascript",
    "toml",
    "vue",
    "markdown",
    "json",
  },
  root_dir = vim.fn.getcwd(),
  cmd_env = { RUST_LOG = "info" },
  init_options = {
    dict_path = "~/.config/nvim/lua/max/plugins/lsp/rustproof/dict.txt",
    diagnostic_severity = "warning",
    dictionaries = {
      {
        language = "en",
        aff = "https://raw.githubusercontent.com/wooorm/dictionaries/refs/heads/main/dictionaries/en/index.aff",
        dic = "https://raw.githubusercontent.com/wooorm/dictionaries/refs/heads/main/dictionaries/en/index.dic",
      },
      {
        language = "en_code",
        aff = "https://raw.githubusercontent.com/maxmilton/hunspell-dictionary/refs/heads/master/en_AU.aff",
        dic = "https://raw.githubusercontent.com/maxmilton/hunspell-dictionary/refs/heads/master/en_AU.dic",
      },
      {
        language = "sv",
        aff = "https://raw.githubusercontent.com/wooorm/dictionaries/refs/heads/main/dictionaries/sv/index.aff",
        dic = "https://raw.githubusercontent.com/wooorm/dictionaries/refs/heads/main/dictionaries/sv/index.dic",
      },
    },
  },
}
