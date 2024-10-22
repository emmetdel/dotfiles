{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
in {
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    apps.neovim.enable = true;
    apps.tools.git.enable = true;
    apps.misc.enable = true;

    # packages to install system-wide
    environment.systemPackages = with pkgs; [
        
    ];
  };
}
