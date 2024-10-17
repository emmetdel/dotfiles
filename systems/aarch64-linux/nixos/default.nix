{pkgs, ...}: {
  imports = [./hardware.nix];

  system.boot.efi.enable = true;

  apps = {
    misc.enable = true;
    tools.git.enable = true;
  };

  suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.

  system.stateVersion = "24.05";
}
