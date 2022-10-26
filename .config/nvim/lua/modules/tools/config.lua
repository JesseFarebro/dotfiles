local config = {}

function config.lightspeed()
  vim.cmd [[
    hi LightspeedCursor gui=reverse
  ]]
end

function config.surround()
  require'nvim-surround'.setup{}
end

return config
