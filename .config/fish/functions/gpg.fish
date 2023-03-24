function gpg --wraps gpg
  command gpg --homedir "$XDG_DATA_HOME"/gnupg $argv
end
