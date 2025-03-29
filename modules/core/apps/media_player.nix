{ config, pkgs, ... }:

let
  jellyfinWrapped = pkgs.writeShellScriptBin "jellyfin-xcb" ''
    exec env QT_QPA_PLATFORM=xcb ${pkgs.jellyfin-media-player}/bin/jellyfinmediaplayer "$@"
  '';
in {
  environment.systemPackages = [
    jellyfinWrapped

    (pkgs.makeDesktopItem {
      name = "jellyfin-media-player-xcb";
      exec = "jellyfin-xcb";
      icon = "multimedia-player";
      desktopName = "Jellyfin Media Player (XWayland)";
      comment = "Jellyfin wrapped to run under XWayland for NVIDIA/Wayland compatibility.";
      categories = [ "AudioVideo" "Player" ];
    })
  ];
}

