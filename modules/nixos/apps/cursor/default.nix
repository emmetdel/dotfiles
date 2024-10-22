{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.cursor;
in {
  options.apps.cursor = with types; {
    enable = mkBoolOpt false "Enable or disable cursor code editor";
  };


  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
        code-cursor
    ];

    home.programs.code-cursor = {
      enable = true;
      package = pkgs.code-cursor;
    };
  };
}
