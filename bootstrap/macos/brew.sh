#!/usr/bin/env sh

which -s brew
if test $? -eq 0; then
  echo "brew already installed, exiting"
  exit 1
fi

# Installation command from brew homepage
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
