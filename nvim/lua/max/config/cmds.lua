function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")
  return s
end

vim.api.nvim_create_user_command("SearchReplace", function(opts)
  local args = opts.fargs

  local result = os.capture(string.format("rg -l '%s' %s | wc -l", args[1], args[3] or "."))
  local command = string.format(
    "rg -l '%s' %s | xargs -I§ -- sh -c 'rg \"%s\" -r \"%s\" --passthru § | sponge §'",
    args[1],
    args[3] or ".",
    args[1],
    args[2]
  )
  vim.print(command)
  os.execute(command)
  vim.print("modified " .. result .. " files")
end, {
  desc = "Search and replace with path",
  nargs = "*",
})
