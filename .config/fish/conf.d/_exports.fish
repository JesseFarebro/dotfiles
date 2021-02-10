# Fish
set -U fish_greeting

# Python
set -gx PYTHONSTARTUP "$PYTHON_CONFIG/startup"
set -gx PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"
set -gx PYTHONBREAKPOINT "ipdb.set_trace"

# Aux
set -gx LESSHISTFILE -
set -gx __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52

# Command specific variables
set -g grc_wrap_commands diff tail gcc g++ ifconfig make mount ping ps tail df
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"
