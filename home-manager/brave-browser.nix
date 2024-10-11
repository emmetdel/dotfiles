{ config, pkgs, ... }:

{
  programs.brave = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    ];
    settings = {
      "browser.enabled_labs_experiments" = [
        "smooth-scrolling@2"
      ];
      "bookmarks_bar.show_on_all_tabs" = true;
      "brave.shields.advanced_view_enabled" = true;
      "brave.rewards.enabled" = false;
      "brave.today.enabled" = false;
    };
  };
}

