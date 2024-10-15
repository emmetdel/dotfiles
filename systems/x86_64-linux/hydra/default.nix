{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [
    ./hardware.nix
  ];

  emmet-dotfiles = {
    nix = enabled;
  }

system.stateVersion = "21.11"; # Did you read the comment?
}
