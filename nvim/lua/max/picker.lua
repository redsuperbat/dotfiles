local M = {}

---@class PickerOpts
---@field cwd string

---@param opts? PickerOpts
function M.files(opts)
  require("snacks").picker.files(opts)
end

---@param opts? PickerOpts
function M.grep(opts)
  require("snacks").picker.grep(opts)
end

---@param opts? PickerOpts
function M.recent(opts)
  require("snacks").picker.recent(opts)
end

return M
