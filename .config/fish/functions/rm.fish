function rm --wraps rm
    if type -q safe-rm
        command safe-rm $argv
    else
        command rm $argv
    end
end
