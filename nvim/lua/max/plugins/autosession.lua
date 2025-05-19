-- Recommended session options for auto-session plugin
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  "rmagatti/auto-session",
  lazy = false,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~", "/" },
    bypass_save_filetypes = { "neo-tree", "qf", "dashboard", "netrw" },
  },
}
