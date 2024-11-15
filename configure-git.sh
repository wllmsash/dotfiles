#!/usr/bin/env sh

# gitconfig
if test -e "$HOME/.gitconfig" && ! test -w "$HOME/.gitconfig"
then
  echo 'Not able to modify "$HOME/.gitconfig"'
  exit 1
fi

if ! grep -Fxq '# Include gitconfig from dotfiles' "$HOME/.gitconfig" 2>/dev/null
then
  printf '# Include gitconfig from dotfiles\n[include]\n  # `~` expanded to $HOME\n  path = ~/.gitconfig_dotfiles\n\n' | cat - "$HOME/.gitconfig" 2>/dev/null | tee "$HOME/.gitconfig" > /dev/null
  echo 'gitconfig_dotfiles included in gitconfig'
else
  echo 'gitconfig_dotfiles already included in gitconfig'
fi
