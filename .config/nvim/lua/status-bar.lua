local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree'}

local colors = {
  fg = "#bfc7d5",
  bg = "#292D3E",

  red = "#ff5370",
  error_red = "#BE5046",
  green = "#C3E88D",
  light_green = "#B5CEA8",
  yellow = "#ffcb6b",
  dark_yellow = "#F78C6C",
  orange = "#CE9178",
  blue = "#82b1ff",
  light_blue = "#9CDCFE",
  vivid_blue = "#4FC1FF",
  purple = "#c792ea",
  blue_purple = "#939ede",
  cyan = "#89DDFF",
  white = "#bfc7d5",
  black = "#292D3E",
  line_grey = "#697098",
  gutter_fg_grey = "#4B5263",
  cursor_grey = "#2C323C",
  visual_grey = "#3E4452",
  menu_grey = "#3E4452",
  special_grey = "#3B4048",
  comment_grey = "#697098",
  vertsplit = "#181A1F"
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    highlight = {colors.purple,colors.purple}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',V= 'VISUAL', [''] = 'VISUAL'}
      return alias[vim.fn.mode()]
    end,
    separator = ' ',
    separator_highlight = {colors.purple,function()
      if not buffer_not_empty() then
        return colors.fg
      end
      return colors.gutter_fg_grey
    end},
    highlight = {colors.special_grey,colors.purple,'bold'},
  },
}
gls.left[3] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.yellow,colors.gutter_fg_grey},
  }
}
gls.left[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.white,colors.gutter_fg_grey},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[5] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.green,colors.purple},
  }
}
gls.left[6] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[7] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.red,colors.purple},
  }
}
gls.left[8] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = ' ',
    separator_highlight = {colors.gutter_fg_grey,colors.bg},
    highlight = {colors.gutter_fg_grey,colors.gutter_fg_grey}
  }
}
gls.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
}
gls.left[10] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}

---------------------------------------------------

gls.right[1]= {
  FileFormat = {
    --provider = 'FileFormat',
    provider = function() return ' 﫦' end,
    separator = ' ',
    separator_highlight = {colors.bg,colors.gutter_fg_grey},
    highlight = {colors.white,colors.gutter_fg_grey,'bold'},
  }
}
gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = {colors.white,colors.gutter_fg_grey},
  },
}
gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {colors.green,colors.gutter_fg_grey},
    highlight = {colors.menu_grey,colors.green},
  }
}

---------------------------------------------------

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.menu_grey,colors.purple}
  }
}
gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.menu_grey,colors.purple}
  }
}
