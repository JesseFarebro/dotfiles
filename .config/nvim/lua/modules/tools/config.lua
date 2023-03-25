local config = {}

function config.telescope()
  local actions = require('telescope.actions')
  require('telescope').setup({
    defaults = {
      prompt_prefix = '   ',
      selection_caret = '  ',
      mappings = {
        i = {
          ["<C-j>"] = {
            actions.move_selection_next, type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<C-k>"] = {
            actions.move_selection_previous, type = "action",
            opts = { nowait = true, silent = true }
          },
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

return config
