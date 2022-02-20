function brew --wraps brew
  env PATH=(string replace (pyenv root)/shims '' "$PATH") command brew $argv
end
