#!/usr/bin/env bash

# bashrc
if ! test -f ~/.bashrc
then
  touch ~/.bashrc
fi

if ! test -L ~/.bashrc
then
  if ! grep -Fxq '# Source bashrc from dotfiles' ~/.bashrc
  then
    printf "# Source bashrc from dotfiles\n[[ -r ~/.bashrc_dotfiles ]] && . ~/.bashrc_dotfiles\n\n" | cat - ~/.bashrc | tee ~/.bashrc
    echo 'Sourced bashrc_dotfiles from bashrc'
  else
    echo 'bashrc_dotfiles already sourced'
  fi
else
  echo 'Not able to modify ~/.bashrc as it is not a regular file'
fi

# bash_profile
if ! test -f ~/.bash_profile
then
  touch ~/.bash_profile
fi

if ! test -L ~/.bash_profile
then
  if ! grep -Fxq '# Source bash_profile from dotfiles' ~/.bash_profile
  then
    printf "# Source bash_profile from dotfiles\n[[ -r ~/.bash_profile_dotfiles ]] && . ~/.bash_profile_dotfiles\n\n" | cat - ~/.bash_profile | tee ~/.bash_profile
    echo 'Sourced bash_profile_dotfiles from bash_profile'
  else
    echo 'bash_profile_dotfiles already sourced'
  fi
else
  echo 'Not able to modify ~/.bash_profile as it is not a regular file'
fi

