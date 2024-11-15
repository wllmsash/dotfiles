#!/usr/bin/env sh

# bashrc
if test -e "$HOME/.bashrc" && ! test -w "$HOME/.bashrc"
then
  echo 'Not able to modify "$HOME/.bashrc"'
  exit 1
fi

if ! grep -Fxq '# Source bashrc from dotfiles' "$HOME/.bashrc" 2>/dev/null
then
  printf '# Source bashrc from dotfiles\nif test -r "$HOME/.bashrc_dotfiles"; then source "$HOME/.bashrc_dotfiles"; fi\n\n' | cat - "$HOME/.bashrc" 2>/dev/null | tee "$HOME/.bashrc" > /dev/null
  echo 'bashrc_dotfiles sourced in bashrc'
else
  echo 'bashrc_dotfiles already sourced in bashrc'
fi

# bash_profile
if test -e "$HOME/.bash_profile" && ! test -w "$HOME/.bash_profile"
then
  echo 'Not able to modify "$HOME/.bash_profile"'
  exit 1
fi

if ! grep -Fxq '# Source bash_profile from dotfiles' "$HOME/.bash_profile" 2>/dev/null
then
  printf '# Source bash_profile from dotfiles\nif test -r "$HOME/.bash_profile_dotfiles"; then source "$HOME/.bash_profile_dotfiles"; fi\n\n' | cat - "$HOME/.bash_profile" 2>/dev/null | tee "$HOME/.bash_profile" > /dev/null
  echo 'bash_profile_dotfiles sourced in bash_profile'
else
  echo 'bash_profile_dotfiles already sourced in bash_profile'
fi
