function ls --wraps exa
  if type -q exa
    command exa \
      --group-directories-first \
      --color-scale \
      --icons \
      $argv
  else
    command ls $argv
  end
end
