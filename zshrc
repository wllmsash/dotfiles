# zsh interactive non-login shell startup file
# Documentation at https://zsh.sourceforge.io/.

if test -r "$HOME/.config/sh/functions"; then source "$HOME/.config/sh/functions"; fi
if test -r "$HOME/.config/sh/environment"; then source "$HOME/.config/sh/environment"; fi
if test -r "$HOME/.config/sh/aliases"; then source "$HOME/.config/sh/aliases"; fi
if test -r "$HOME/.config/sh/config"; then source "$HOME/.config/sh/config"; fi
if test -r "$HOME/.config/zsh/functions"; then source "$HOME/.config/zsh/functions"; fi
if test -r "$HOME/.config/zsh/prompt"; then source "$HOME/.config/zsh/prompt"; fi

# Set tty settings.
stty -ixon                      # Disable flow control. If enabled C-S suspends output and C-Q resumes output.

# Set zsh options.
# See https://zsh.sourceforge.io/Doc/Release/Options.html.
setopt NOTIFY                   # Report the status of background jobs immediately.
setopt PROMPT_SUBST             # Allow substitution in PROMPT.

# Set zsh options for history.
setopt APPEND_HISTORY           # Append to avoid concurrent shells overwriting each others history.
setopt EXTENDED_HISTORY         # Write diagnostic information.
setopt INC_APPEND_HISTORY       # Append immediately.
setopt HIST_FIND_NO_DUPS        # Remove duplicates from history search.
setopt HIST_IGNORE_SPACE        # Ignore writing commands starting with a space.
setopt HIST_IGNORE_ALL_DUPS     # Remove any older duplicates when writing.
setopt HIST_NO_STORE            # Ignore writing the `history` command.
setopt HIST_SAVE_NO_DUPS        # Remove duplicates when writing.

# Type the path array to keep only the first instance of each duplicate value.
typeset -U path

# Put zsh in vi mode and use the viins keymap.
# See https://zsh.sourceforge.io/Guide/zshguide04.html.
bindkey -v

# Increase command history size and persist.
HISTSIZE=16384                  # Increase command history size.
HISTFILE=~/.histfile            # Persist history to disk.
SAVEHIST=$HISTSIZE              # Persist all in-memory history.

# Configure XDG base directories.
ensure_xdg_directories
prepend_path "$XDG_BIN_HOME"

# Configure command coloring.
try_set_ls_colors

# Set key bindings.
bindkey '^R' history-incremental-search-backward                # Search command history.
lazyload edit-command-line && zle -N edit-command-line          # Widget defined in zshcontrib.
bindkey '^X^E' edit-command-line                                # Edit command line in VISUAL editor.

# Try to use fzf to search command history.
if command_exists 'fzf'; then
  # Disable the builtin bindkey to stop `fzf --zsh` from forcing it's key binding opinions on us.
  bindkey() {}

  eval "$(fzf --zsh)"

  # Re-enable the builtin bindkey.
  unset -f bindkey

  bindkey '^R' fzf-history-widget
fi

# Style prompt.
set_prompt

# Inject optional local configuration.
# Some commands must be called at the end of this file. Injecting additional configuration here gives us an opportunity
# to add machine specific configuration before these commands are run.
# An example is adding extra completions before we call `compinit`.
if test -r "$HOME/.zshrc_local"; then source "$HOME/.zshrc_local"; fi

# Enable command completion for zsh and bash completion functions.
lazyload compinit && compinit
lazyload bashcompinit && bashcompinit

# Add plugins.
# https://github.com/zsh-users/zsh-autosuggestions.git
add_plugin "zsh-autosuggestions/zsh-autosuggestions.zsh"
# https://github.com/zsh-users/zsh-syntax-highlighting
# Must be sourced last.
add_plugin "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Start local SSH agent.
try_start_keychain

# Optional
#
# Load all "*.key" files in "$HOME/.ssh" into keychain for 1 day (1440 minutes).
# keychain --quiet --timeout 1440 "$(find "$HOME/.ssh" -name "*.key")"
