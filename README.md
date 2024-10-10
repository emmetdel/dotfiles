# Dotfiles

This is to describe the barebones development system I use. Supports NixOS on Silicon Macs.

Featuring:

- Wezterm
- Tmux
- Fish
- Neovim
- OSX
  - darwin-nix
  - Hammerspoon
  - homebrew mas
  - yabai

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

### NixOS

`sudo nixos-install --flake github:emmetdel/dotfiles#nixos`

### Darwin/Linux

`nix run nix-darwin -- switch --flake github:emmetdel/dotfiles`

`sudo nixos-rebuild switch --flake ~/src/github.com/emmetdelaney/dotfiles`
