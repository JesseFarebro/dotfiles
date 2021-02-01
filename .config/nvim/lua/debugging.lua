local dap = require('dap')

dap.adapters.python = {
  type = 'executable';
  request = 'launch';
  name = 'Launch file';

  program = '${file}';
  pythonPath = function()
    return '/usr/bin/python'
  end;
}

