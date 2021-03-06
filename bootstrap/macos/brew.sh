#!/usr/bin/env bash

which -s brew
if [[ $? == 0 ]];
then
  echo "brew already installed, exiting"
  exit 1
fi

# Installation command from brew homepage
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
