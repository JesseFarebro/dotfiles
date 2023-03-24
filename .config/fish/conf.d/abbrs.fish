status is-interactive || exit

abbr --add graq 'ssh graham squeue -u $USER'
abbr --add cdrq 'ssh cedar squeue -u $USER'
abbr --add blgq 'ssh beluga squeue -u $USER'
abbr --add nvlq 'ssh narval squeue -u $USER'

abbr --add vim 'nvim'
abbr --add vimdiff 'nvim -d'

abbr --add mamba 'micromamba'
