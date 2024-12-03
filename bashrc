# Sourced in interactive non-login shells.
# See https://linux.die.net/man/1/bash for information on the different startup files.
# See https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856
# for more information on interactive and login shells.

# When bash has stdin connected to a network connection and is being run non-interactively, for example via scp, bash
# will attempt to load bashrc. If bashrc writes to stdout it will cause unexpected issues.
# Place a guard here to skip sourcing this file in non-interactive scenarios.
# See https://linux.die.net/man/1/bash for cases where bashrc is sourced.
# See https://unix.stackexchange.com/questions/715807/what-does-if-not-running-interactively-dont-do-anything-in-the-bashrc-file
# for more information on this issue.
if [[ $- != *i* ]]; then
  return
fi

if test -r "$HOME/.config/sh/functions"; then source "$HOME/.config/sh/functions"; fi
if test -r "$HOME/.config/sh/environment"; then source "$HOME/.config/sh/environment"; fi
if test -r "$HOME/.config/sh/aliases"; then source "$HOME/.config/sh/aliases"; fi
if test -r "$HOME/.config/sh/config"; then source "$HOME/.config/sh/config"; fi
if test -r "$HOME/.config/bash/functions"; then source "$HOME/.config/bash/functions"; fi

# Configure XDG base directories.
ensure_xdg_directories
prepend_path "$XDG_BIN_HOME"

# Configure command coloring.
try_set_ls_colors

# Initialize applications.
try_init_tmuxifier

# Inject optional local configuration.
if test -r "$HOME/.bashrc_local"; then source "$HOME/.bashrc_local"; fi
