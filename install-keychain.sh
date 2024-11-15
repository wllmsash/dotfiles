#!/usr/bin/env sh

# Test if keychain is already installed
if command -v keychain >/dev/null 2>&1; then
  echo 'keychain already installed, continuing'
  exit 0
fi

echo "Install keychain? [y/n] "
read SHOULD_INSTALL
case "$SHOULD_INSTALL" in
  [Yy]*) break;;
  *) echo 'skipping installation'; exit 0;;
esac

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
