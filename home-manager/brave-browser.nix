{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    ];
  };
}

