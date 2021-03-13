#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]];
then
  echo "Requires brew, exiting"
  exit 1
fi

brew update
brew install bash-completion

if ! grep -Fxq '# dotfiles: bash-completion' ~/.bashrc;
then
  cat <<EOF >> ~/.bashrc
# dotfiles: bash-completion
[[ -r /usr/local/etc/profile.d/bash_completion.sh ]] && . /usr/local/etc/profile.d/bash_completion.sh

EOF
fi
