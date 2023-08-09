#!/usr/bin/env bash
# Occasionally updates break my system, these are some of the steps I typically have to take to reinstall:

# Revert system bash and zsh configuration to a pre-nix state
sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc
sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
sudo mv /etc/zshrc.backup-before-nix /etc/zshrc

# Reinstall nix
sh <(curl -L https://nixos.org/nix/install)

# Reclaim the user nix profile
sudo chown -R "$(whoami)": "/nix/var/nix/profiles/per-user/$(whoami)"
