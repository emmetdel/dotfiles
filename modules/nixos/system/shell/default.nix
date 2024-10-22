{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum ["nushell" "fish" "zsh"]) "zsh" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      zoxide
      starship
    ];

    programs.zsh.enable = true;

    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.zsh;

    home.programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
    home.configFile."starship.toml".source = ./starship.toml;

    environment.shellAliases = {

    };

    home.programs.zoxide = {
      enable = true;
    };

    # Actual Shell Configurations
    home.programs.zsh = mkIf (cfg.shell == "zsh") {
      enable = true;
      shellAliases = {
        ls = "eza -la --icons --no-user --no-time --git -s type";
        cat = "bat";
        rebuild = "sudo nixos-rebuild switch --flake $HOME/dotfiles";
        ".." = "cd ..";
        neofetch = "nitch";
      };
    };

  };
}
