function ls --wraps lsd
    if type -q lsd
        command lsd \
            --group-directories-first \
            $argv
    else if type -q exa
        command exa \
            --group-directories-first \
            --color-scale \
            --icons \
            $argv
    else
        command ls $argv
    end
end
