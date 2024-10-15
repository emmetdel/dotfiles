_: final: prev: {
  dotfiles = (prev.dotfiles or { }) // {
    yt-music = prev.makeDesktopItem {
      name = "YT Music";
      desktopName = "YT Music";
      genericName = "Music, from YouTube.";
      exec = ''${prev.lib.getExe final.firefox} "https://music.youtube.com/?dotfiles.app=true"'';
      icon = ./icon.svg;
      type = "Application";
      categories = [
        "AudioVideo"
        "Audio"
        "Player"
      ];
      terminal = false;
    };
  };
}
