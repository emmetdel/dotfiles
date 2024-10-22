{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.firefox;
in {
  options.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable or disable firefox browser";
  };

  config = mkIf cfg.enable {
    home.programs.firefox = {
      enable = true;
      package = pkgs.firefox;
    };

    home.programs.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      privacy-badger
    ];

    # home.persist.directories = [
    #   ".librewolf"
    #   ".cache/librewolf"
    # ];
  };
}
