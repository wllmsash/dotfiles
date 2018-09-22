# Interactive non-login shell startup file

# Source original bashrc (before dotfiles)
[[ -r ~/.bashrc_original ]] && . ~/.bashrc_original

### WSL (Bash on Windows)

# umask defaults to 000 causing new files and directories to have loose permissions
# This fix sets the correct umask
#
# Link: https://github.com/Microsoft/WSL/issues/352
if test "$(umask)" -eq '000' || test "$(umask)" -eq '0000'; then umask 022; fi

### OSX

if [[ "$OSTYPE" == "darwin"* ]]; then

# Enable coloring of terminal
export CLICOLOR=1

# Better coloring of ls output
export LSCOLORS=ExFxBxDxCxegedabagacad

# Primary prompt customization
#   username@hostname$
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

fi

### Aliases

# Source bash aliases
[[ -r ~/.bash_aliases ]] && . ~/.bash_aliases
