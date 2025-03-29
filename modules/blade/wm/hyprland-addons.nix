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
    # SVG Support
    librsvg
    # External Monitor
    wlr-randr

    # Snapshot Editing
    swappy
    grim
    slurp

    # Notifications
    swaynotificationcenter
    libnotify
    dunst

    # Wallpaper & visuals
    swww
    wallust
    cava


    # Logout menu
    wlogout

    # Brightness
    brightnessctl

    # Video
    mpv

    # Security
    openssl

    # Theming & appearance
    # Custom desktop entry for nwg-look with a settings icon
    (pkgs.makeDesktopItem {
      name = "nwg-look-settings";
      exec = "nwg-look";
      icon = "preferences-system"; # 🎯 this sets the generic settings icon
      desktopName = "GTK Settings";
      comment = "Configure GTK themes, icons, and cursors";
      categories = [ "Settings" "Utility" ];
    })
  ];
}

