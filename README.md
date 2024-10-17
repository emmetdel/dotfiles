# Dotfiles for my Nix based Systems

## Generate ISO

To generate an installation ISO, use the following command:

```bash
nix build .#nixosConfigurations.x86_64-install-iso.config.system.build.isoImage
```

## Generate ISO with Flakes

```bash
nixos-generate --flake .#x86_64-install-iso --format iso
```

```bash
# Install nixos-generators to profile
nix profile install github:nix-community/nixos-generators
```
