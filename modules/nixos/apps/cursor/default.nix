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

  environment.systemPackages = with pkgs; [
    code-cursor
  ];

  config = mkIf cfg.enable {
    home.programs.cursor = {
      enable = true;
      package = pkgs.cursor;
    };
  };
}
