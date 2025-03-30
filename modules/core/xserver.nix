{ pkgs, lib, username, ... }:

{
  # Enable LY
  services.displayManager.ly.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = false;
  services.greetd.enable = false;

  # LY config.ini written declaratively
  # environment.etc."ly/config.ini".source = lib.mkForce (builtins.toFile "ly-config.ini" ''
  #   [main]
  #   font = JetBrainsMono Nerd Font:size=12
  #   show_hostname = true
  #   show_time = true
  #   border = 120,120,255
  #   cursor = 200,100,255
  #   shadow = true
  #   bg = 0,0,0
  #   fg = 255,255,255
  #   shutdown = /run/current-system/systemd/bin/systemctl poweroff
  #   reboot = /run/current-system/systemd/bin/systemctl reboot
  #   suspend = /run/current-system/systemd/bin/systemctl suspend
  #
  # '');
}

