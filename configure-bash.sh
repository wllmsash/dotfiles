#!/usr/bin/env sh

# bashrc
if test -e ~/.bashrc && ! test -f ~/.bashrc
then
  echo 'Not able to modify ~/.bashrc as it is not a regular file'
  exit 1
fi

if ! grep -Fxq '# Source bashrc from dotfiles' ~/.bashrc
then
  printf "# Source bashrc from dotfiles\n[[ -r ~/.bashrc_dotfiles ]] && . ~/.bashrc_dotfiles\n\n" | cat - ~/.bashrc | tee ~/.bashrc > /dev/null
  echo 'Sourced bashrc_dotfiles from bashrc'
else
  echo 'bashrc_dotfiles already sourced'
fi

# bash_profile
if test -e ~/.bash_profile && ! test -f ~/.bash_profile
then
  echo 'Not able to modify ~/.bash_profile as it is not a regular file'
  exit 1
fi

if ! grep -Fxq '# Source bash_profile from dotfiles' ~/.bash_profile
then
  printf "# Source bash_profile from dotfiles\n[[ -r ~/.bash_profile_dotfiles ]] && . ~/.bash_profile_dotfiles\n\n" | cat - ~/.bash_profile | tee ~/.bash_profile > /dev/null
  echo 'Sourced bash_profile_dotfiles from bash_profile'
else
  echo 'bash_profile_dotfiles already sourced'
fi

