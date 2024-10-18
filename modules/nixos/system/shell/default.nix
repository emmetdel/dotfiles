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
      ".." = "cd ..";
      neofetch = "nitch";
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
      };
    };

    # Enable all if nushell
    home.programs.nushell = mkIf (cfg.shell == "nushell") {
      enable = true;
      shellAliases = config.environment.shellAliases // {ls = "ls";};
      envFile.text = "";
      extraConfig = ''
        $env.config = {
        	show_banner: false,
        }

        def , [...packages] {
            nix shell ($packages | each {|s| $"nixpkgs#($s)"})
        }
      '';
    };
  };
}
