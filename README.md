# Dotfiles

This is to describe the barebones development system I use. Supports Silicon Macs.

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).
On WSL2: [WSL2 Nix](https://github.com/nix-community/NixOS-WSL?tab=readme-ov-file)

## Bootstrap

### Darwin/Linux

`nix run nix-darwin -- switch --flake github:emmetdel/dotfiles`

## Update

### NixOS

`sudo nixos-rebuild switch --flake ~/src/github.com/emmetdel/dotfiles`

### Darwin

`darwin-rebuild switch --flake ~/src/github.com/emmetdel/dotfiles`
