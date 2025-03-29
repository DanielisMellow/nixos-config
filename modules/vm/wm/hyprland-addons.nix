
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Hyprland
    waybar
    rofi-wayland
    pyprland
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    xdg-desktop-portal-hyprland
    # Snapshot Editng
    swappy
    # Notifications
    swaynotificationcenter
    swww
    wallust
    cava
    nwg-look
    # Notifications
    libnotify
    dunst
    openssl

    # Logout menu
    wlogout
    ];
}
