# Interactive non-login shell startup file

# Source bash aliases
[[ -r ~/.bash_aliases ]] && . ~/.bash_aliases

# Primary prompt customization
#   username@hostname$
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# Enable colouring of terminal
export CLICOLOR=1

# Better colouring of ls output
export LSCOLORS=ExFxBxDxCxegedabagacad
