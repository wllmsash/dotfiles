#!/usr/bin/env sh

# zshrc
if test -e "$HOME/.zshrc" && ! test -w "$HOME/.zshrc"
then
  echo 'Not able to modify "$HOME/.zshrc"'
  exit 1
fi

if ! grep -Fxq '# Source zshrc from dotfiles' "$HOME/.zshrc" 2>/dev/null
then
  printf '# Source zshrc from dotfiles\nif test -r "$HOME/.zshrc_dotfiles"; then source "$HOME/.zshrc_dotfiles"; fi\n\n' | cat - "$HOME/.zshrc" 2>/dev/null | tee "$HOME/.zshrc" > /dev/null
  echo 'zshrc_dotfiles sourced in zshrc'
else
  echo 'zshrc_dotfiles already sourced in zshrc'
fi

# zprofile
if test -e "$HOME/.zprofile" && ! test -w "$HOME/.zprofile"
then
  echo 'Not able to modify "$HOME/.zprofile"'
  exit 1
fi

if ! grep -Fxq '# Source zprofile from dotfiles' "$HOME/.zprofile" 2>/dev/null
then
  printf '# Source zprofile from dotfiles\nif test -r "$HOME/.zprofile_dotfiles"; then source "$HOME/.zprofile_dotfiles"; fi\n\n' | cat - "$HOME/.zprofile" 2>/dev/null | tee "$HOME/.zprofile" > /dev/null
  echo 'zprofile_dotfiles sourced in zprofile'
else
  echo 'zprofile_dotfiles already sourced in zprofile'
fi
