#!/usr/bin/env sh

which -s brew
if test $? -ne 0; then
  echo "Requires brew, exiting"
  exit 1
fi

brew update
brew install git
