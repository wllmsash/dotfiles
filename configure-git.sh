#!/usr/bin/env bash

# gitconfig
if ! test -f ~/.gitconfig
then
  touch ~/.config
fi

if ! test -L ~/.gitconfig
then
  if ! grep -Fxq '# Include gitconfig from dotfiles' ~/.gitconfig
  then
    printf "# Include gitconfig from dotfiles\n[include]\n  path = ~/.gitconfig_dotfiles\n\n" | cat - ~/.gitconfig | tee ~/.gitconfig
    echo 'Included gitconfig_dotfiles from gitconfig'
  else
    echo 'gitconfig_dotfiles already included'
  fi
else
  echo 'Not able to modify ~/.gitconfig as it is not a regular file'
fi

