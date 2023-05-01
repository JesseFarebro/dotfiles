local config = {}

function config.cmp()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  cmp.setup({
    enabled = function()
      -- disable completion in comments
      local context = require('cmp.config.context')
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
      end
    end,
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    window = {
      documentation = cmp.config.window.bordered({
        border = 'solid',
        side_padding = 2,
      }),
      completion = cmp.config.window.bordered({
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        border = 'none',
        col_offset = -4,
        side_padding = 1,
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'emoji' },
    }, {
      { name = 'buffer' },
    }),
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = cmp.mapping(function(fallback)
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
        elseif cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    formatting = {
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. (strings[1] or '') .. ' '
        kind.menu = '    (' .. (strings[2] or '') .. ')'

        return kind
      end,
      fields = { 'kind', 'abbr', 'menu' },
    },
  })

  -- `/` cmdline setup.
  cmp.setup.cmdline({ '/', '?' }, {
    view = {
      entries = { name = 'wildmenu', separator = ' | ', winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None' },
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.cmdline({
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = {
      { name = 'buffer' },
    },
  })

  -- `:` cmdline setup.
  cmp.setup.cmdline(':', {
    view = {
      entries = { name = 'wildmenu', separator = ' | ', winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None' },
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.cmdline({
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

return config
