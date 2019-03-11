# dotfiles

A repository to host my dotfiles and general environment configuration. The [dotbot][dotbot] bootstrapper is used for installation and is included in this repository.

The bootstrapper creates symlinks to dotfiles in the user home directory ``~`` along with running shell scripts for more involved installation tasks.

## Installation

The full list of operations performed by the installer can be found in the [installation configuration](install.conf.yaml).

The installation is idempotent, meaning it can be run multiple times without changing the final result.

```
git clone https://github.com/wllmsash/dotfiles
cd dotfiles
./install
```

## Supported Environments

These dotfiles have been tested and are used in the following environments:

* macOS Mojave 10.14.3
* Ubuntu 18.04 LTS

## License

Released under the MIT license. See [LICENSE][license] for details.

[dotbot]: https://github.com/anishathalye/dotbot
[license]: LICENSE
