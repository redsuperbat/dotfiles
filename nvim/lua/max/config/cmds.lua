vim.api.nvim_create_user_command("SearchReplace", function(opts)
  local args = opts.fargs

  local command = string.format(
    "rg -l '%s' | xargs -I§ -- sh -c 'rg \"%s\" -r \"%s\" --passthru § | sponge §'",
    args[1],
    args[1],
    args[2],
    args[3] or "."
  )
  os.execute(command)
end, {
  desc = "Search and replace with path",
  nargs = "?",
})
