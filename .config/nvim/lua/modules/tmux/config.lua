local config = {}

function config.tmux()
  require('tmux').setup {
    copy_sync = {
      enable = false
    },
    navigation = {
      enable_default_keybindings = false
    },
    resize = {
      enable_default_keybindings = false
    }
  }
end


function config.runner()
  vim.g.VtrStripLeadingWhitespace = false
  vim.g.VtrClearEmptyLines = false
  vim.g.VtrAppendNewline = true
end

return config
