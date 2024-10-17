_: {
  # Enable Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Disable wpa_supplicant
  networking.wireless.enable = false;
  
  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable common modules
  suites.common.enable = true;

  system.stateVersion = "24.05";
}
