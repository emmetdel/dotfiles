# Dotfiles

Dotfiles for my NixOS and Darwin systems using snowflake.

## Install Nix

On OSX: [Determinate Systems Installer](https://github.com/DeterminateSystems/nix-installer).

### NixOS

```bash
# Installing:
sudo nixos-install --flake github:emmetdel/dotfiles#nixos
```

```bash
# Rebuilding:
sudo nixos-rebuild switch --flake github:emmetdel/dotfiles#nixos
```

```bash
# Upgrading:
sudo nixos-rebuild upgrade --flake github:emmetdel/dotfiles#nixos
```

### Darwin/Linux

```bash
# Installing:
nix run nix-darwin -- switch --flake github:emmetdel/dotfiles
```
