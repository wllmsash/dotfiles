#!/usr/bin/env sh

# gitconfig
if test -e ~/.gitconfig && ! test -f ~/.gitconfig
then
  echo 'Not able to modify ~/.gitconfig as it is not a regular file'
  exit 1
fi

if ! grep -Fxq '# Include gitconfig from dotfiles' ~/.gitconfig
then
  printf "# Include gitconfig from dotfiles\n[include]\n  path = ~/.gitconfig_dotfiles\n\n" | cat - ~/.gitconfig | tee ~/.gitconfig > /dev/null
  echo 'Included gitconfig_dotfiles from gitconfig'
else
  echo 'gitconfig_dotfiles already included'
fi
