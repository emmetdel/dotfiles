{pkgs, ...}: {
  imports = [./hardware.nix];

  system = {
    # Enable Bootloader
    boot.efi.enable = true;

    # Set environment variables
    env.enable = true;

    # Set nix
    nix.enable = true;

    # Set shell
    shell.enable = true;
  };


  apps = {
    misc.enable = true;
    tools.git.enable = true;
    tools.direnv.enable = true;
    tools.lazygit.enable = true;
    tools.commitizen.enable = true;
  };


  environment.systemPackages = with pkgs; [
    # Any particular packages only for this host
    just

  ];

  suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "22.11";
  # ======================== DO NOT CHANGE THIS ========================
}
