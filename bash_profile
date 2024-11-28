# Sourced in interactive and non-interactive login shells.
# See https://linux.die.net/man/1/bash for information on the different startup files.
# See https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856
# for more information on interactive and login shells.

# Source bashrc in interactive login shells since it is only sourced in interactive non-login shells by default.
# See https://linux.die.net/man/1/bash for information on the different startup files.
if [[ $- == *i* ]] && test -r "$HOME/.bashrc"; then source "$HOME/.bashrc"; fi
