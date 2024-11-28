# Sourced in interactive and non-interactive login shells.
# See https://linux.die.net/man/1/zsh for information on the different startup files.
# See https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856
# for more information on interactive and login shells.

# Source interactive non-login shell startup file
if test -r "$HOME/.zshrc"; then source "$HOME/.zshrc"; fi
