local M = {}

function M.is_dir(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "directory"
end

function M.path_exists(path)
  return vim.uv.fs_stat(path)
end

--- This function searches for a file by its name starting from the directory of the given buffer.
--- If the file is found, the function returns the path to the file. If not, it returns nil.
--- @param filename string
--- @param bufnr number
--- @return string | nil
function M.find_file(filename, bufnr)
  local starting_dir = vim.api.nvim_buf_get_name(bufnr)
  local file_path = vim.fs.find(filename, {
    upward = true,
    path = starting_dir,
    type = "file",
  })[1]
  if file_path then
    return file_path
  end
  return nil
end

--- This function searches for a file by its name starting from the directory of the given buffer
--- and returns the directory path in which the file is located if it is found. If not, it returns nil.
--- @param filename string: The name of the file to search for.
--- @param bufnr number: The buffer number to start the search from.
--- @return string | nil: The directory path containing the file or nil if not found.
function M.find_file_directory(filename, bufnr)
  local file_path = M.find_file(filename, bufnr)
  if file_path then
    return vim.fn.fnamemodify(file_path, ":h")
  end
  return nil
end

function M.root()
  local filenames = {
    "package.json",
    "lazyvim.json",
    ".gitignore",
    "tsconfig.json",
    "deno.json",
    "Cargo.toml",
  }
  -- Start from the current directory
  local starting_dir = vim.api.nvim_buf_get_name(0)

  -- Traverse upwards until we find one of the files or reach the root
  for _, filename in ipairs(filenames) do
    local file_path = vim.fs.find(filename, {
      upward = true,
      path = starting_dir,
      type = "file",
    })[1]

    if file_path then
      local directory = vim.fs.dirname(file_path)
      if directory == "." then
        return vim.fn.getcwd()
      end
      return directory
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
