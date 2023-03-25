local config = {}

function config.runner()
  vim.g.VtrStripLeadingWhitespace = false
  vim.g.VtrClearEmptyLines = false
  vim.g.VtrAppendNewline = true
end

return config
