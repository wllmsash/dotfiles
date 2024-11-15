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

# Start keychain if it's installed and the shell is interactive
#
# Imports the environment variables for the keychain managed ssh-agent or starts
# a new keychain managed ssh-agent if one has not been started already.
# Only start keychain in interactive shells as non-interactive shells may want to
# forward their own agents.
#
# --agents ssh: Only use keychain for ssh (as opposed to gpg etc)
# --timeout 3: Sets the default timeout for keys added to the agent to 3 minutes
# --noinherit: Do not inherit agents from existing $SSH_AGENT_PID or $SSH_AGENT_SOCK
#   environment variables. This includes any non keychain managed SSH agents (with PIDs
#   and sockets) as well as all forwarded SSH agents (with only sockets).
#   By extension, this includes the macOS Keychain, as _I think_ this uses agent
#   forwarding to add the OS managed keys to the agent.
#   See https://superuser.com/questions/88470/how-to-use-mac-os-x-keychain-with-ssh-keys
#   for more info.
# --quiet: Hide the keychain welcome message on init.
# --eval: Similar to eval $(ssh-agent -s) this needs to export environment variables
#   so must be evaluated in the current shell.
if tty -s && command -v keychain >/dev/null 2>&1; then
  eval $(keychain --agents ssh --timeout 3 --noinherit --quiet --eval)
fi

# Example: Load all *.key files in ~/.ssh into keychain for 1 day (1440 minutes)
# keychain --quiet --timeout 1440 $(find $HOME/.ssh -name "*.key")
