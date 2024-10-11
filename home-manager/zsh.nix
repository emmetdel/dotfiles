{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "kubectl"
      ];
    };

    initExtra = ''
      # Custom configurations
      setopt AUTO_CD
      setopt EXTENDED_GLOB
      setopt NOMATCH
      setopt NOTIFY
      setopt INTERACTIVE_COMMENTS

      # Aliases
      alias ls='ls --color=auto'
      alias ll='ls -lah'
      alias grep='grep --color=auto'
    '';

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      gst = "git status";
      gco = "git checkout";
      gaa = "git add --all";
    };
  };
}
