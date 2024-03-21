status is-interactive || exit

abbr --add graq 'ssh graham squeue --me'
abbr --add cdrq 'ssh cedar squeue --me'
abbr --add blgq 'ssh beluga squeue --me'
abbr --add nvlq 'ssh narval squeue --me'
abbr --add milaq 'ssh mila squeue --me'

abbr --add vim nvim
abbr --add vimdiff 'nvim -d'

abbr --add mamba micromamba
