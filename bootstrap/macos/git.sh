#!/usr/bin/env bash

which -s brew
if [[ $? != 0 ]];
then
  echo "Requires brew, exiting"
  exit 1
fi

brew update
brew install git
