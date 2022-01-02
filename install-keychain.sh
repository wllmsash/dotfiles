#!/usr/bin/env bash

# Test if keychain is already installed
if command -v keychain &> /dev/null; then
  echo 'keychain already installed, continuing'
  exit 0
fi

read -p "Install keychain? [y/n]" -n 1 -r SHOULD_INSTALL; echo ""
if [[ ! $SHOULD_INSTALL =~ ^[Yy]$ ]]; then
  echo 'skipping installation'
  exit 0
fi

KEYCHAIN_VERSION=2.8.5

# Download keychain release to /tmp
curl --location --output "/tmp/keychain-$KEYCHAIN_VERSION.tar.gz" "https://github.com/funtoo/keychain/archive/refs/tags/$KEYCHAIN_VERSION.tar.gz"

# Extract keychain release
sudo tar --extract --gzip --file "/tmp/keychain-$KEYCHAIN_VERSION.tar.gz" --directory /usr/local/share
sudo mv "/usr/local/share/keychain-$KEYCHAIN_VERSION" "/usr/local/share/keychain"

# Symlink keychain script as a binary
sudo ln -s /usr/local/share/keychain/keychain /usr/local/bin

# Clean up
rm "/tmp/keychain-$KEYCHAIN_VERSION.tar.gz"

