#!/usr/bin/env sh

which -s brew
if test $? -ne 0; then
  echo "Requires brew, exiting"
  exit 1
fi

brew update
brew install bash-completion

if ! grep -Fxq '# dotfiles: bash-completion' "$HOME/.bashrc";
then
  cat <<EOF >> "$HOME/.bashrc"
# dotfiles: bash-completion
if test -r "/usr/local/etc/profile.d/bash_completion.sh"; then source "/usr/local/etc/profile.d/bash_completion.sh"; fi

EOF
fi
