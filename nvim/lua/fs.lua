local logger = require("plenary.log").new({
  plugin = "lspconfig",
})

local M = {}

function M.root()
  local filenames = {
    "package.json",
    "lazyvim.json",
    ".gitignore",
    "tsconfig.json",
    "Cargo.toml",
  }
  -- Start from the current directory
  local starting_dir = vim.api.nvim_buf_get_name(0)

  -- Traverse upwards until we find one of the files or reach the root
  for _, filename in ipairs(filenames) do
    local file_path = vim.fs.find(filename, {
      upward = true,
      path = starting_dir,
    })[1]

    if file_path then
      return vim.fs.dirname(file_path)
    end
  end

  return vim.fn.getcwd()
end

function M.git()
  local git_dir = vim.fs.find(".git", { upward = true, type = "directory" })

  if #git_dir > 0 then
    return vim.fs.dirname(git_dir[1])
  else
    return nil
  end
end

return M
