local config = {}

function config.telescope()
  local actions = require('telescope.actions')

  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd([[packadd plenary.nvim]])
    vim.cmd([[packadd popup.nvim]])
    vim.cmd([[packadd telescope-fzy-native.nvim]])
    vim.cmd([[packadd telescope-file-browser.nvim]])
  end
  require('telescope').setup({
    defaults = {
      prompt_prefix = '   ',
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      },
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
        vertical = { mirror = false },
      },
      sorting_strategy = 'ascending',
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
end

function config.lightspeed()
  vim.cmd [[
    hi LightspeedCursor gui=reverse
  ]]
end

function config.surround()
  require'nvim-surround'.setup{}
end

return config