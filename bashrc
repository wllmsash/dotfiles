# bash interactive non-login shell startup file

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

# Start local SSH agent.
try_start_keychain

# Optional
#
# Load all "*.key" files in "$HOME/.ssh" into keychain for 1 day (1440 minutes).
# keychain --quiet --timeout 1440 "$(find "$HOME/.ssh" -name "*.key")"
