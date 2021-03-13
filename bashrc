# Interactive non-login shell startup file

# Source original bashrc (before dotfiles)
[[ -r ~/.bashrc_original ]] && . ~/.bashrc_original

### macOS

if [[ "$OSTYPE" == "darwin"* ]]; then

# Enable coloring of terminal
export CLICOLOR=1

# Better coloring of ls output
export LSCOLORS=ExFxBxDxCxegedabagacad

# Primary prompt customization
#   username@hostname$
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# Bash completion
# Requires `brew install bash-completion` to work
# For git completion requires `brew install git` also
[[ -r /usr/local/etc/profile.d/bash_completion.sh ]] && . /usr/local/etc/profile.d/bash_completion.sh

fi

### Functions

# Source bash functions
[[ -r ~/.bash_functions ]] && . ~/.bash_functions

# Source private bash functions (from a private dotfiles)
[[ -r ~/.bash_functions_private ]] && . ~/.bash_functions_private

### Aliases

# Source bash aliases
[[ -r ~/.bash_aliases ]] && . ~/.bash_aliases

# Source private bash aliases (from a private dotfiles)
[[ -r ~/.bash_aliases_private ]] && . ~/.bash_aliases_private
