{pkgs, ...}: {
  imports = [./hardware.nix];

  # Enable Bootloader
  system.boot.efi.enable = true;

  # Enable XKB windowing system
  system.xkb.enable = true;

  # Enable misc apps
  apps.misc.enable = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enables the basics, like audio, networking, ssh, etc.
  suites.common.enable = true; 
  suites.desktop.enable = true;

  system.stateVersion = "24.05";
}
