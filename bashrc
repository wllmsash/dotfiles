# Interactive non-login shell startup file

### macOS

if [[ "$OSTYPE" == "darwin"* ]]; then

# Enable coloring of terminal
export CLICOLOR=1

# Better coloring of ls output
export LSCOLORS=ExFxBxDxCxegedabagacad

# Primary prompt customization
#   username@hostname$
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

fi

### Functions

# Source bash functions
[[ -r ~/.bash_functions_dotfiles ]] && . ~/.bash_functions_dotfiles

### Aliases

# Source bash aliases
[[ -r ~/.bash_aliases_dotfiles ]] && . ~/.bash_aliases_dotfiles

### Environment

# Disable homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

