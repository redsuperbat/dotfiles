local bg = "#1f1f28"

--- @param group string | string[]
local function set_hl(group)
  if type(group) == "string" then
    vim.api.nvim_set_hl(0, group, { bg = bg })
  else
    for _, v in ipairs(group) do
      vim.api.nvim_set_hl(0, v, { bg = bg })
    end
  end
end

return {
  bg = bg,
  set_hl = set_hl,
}
