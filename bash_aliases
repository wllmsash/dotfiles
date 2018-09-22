# Script and command aliases for bash

# Improve ls
#   F = append type indicator
#   h = human readable formatting
if [[ "$OSTYPE" == "darwin"* ]]; then # OSX
	alias ls="ls -Fh"
else
	alias ls="ls -Fh --color=auto"
fi

# List all
#   A = show all but . and ..
#   l = long list formatting
alias ll="ls -lA"
