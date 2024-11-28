# Sourced in interactive non-login shells.
# See https://linux.die.net/man/1/bash for information on the different startup files.
# See https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell/46856#46856
# for more information on interactive and login shells.

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

# Inject optional local configuration.
if test -r "$HOME/.bashrc_local"; then source "$HOME/.bashrc_local"; fi

# Start local SSH agent.
try_start_keychain

# Optional
#
# Load all "*.key" files in "$HOME/.ssh" into keychain for 1 day (1440 minutes).
# keychain --quiet --timeout 1440 "$(find "$HOME/.ssh" -name "*.key")"
