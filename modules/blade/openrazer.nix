{ config, lib, pkgs, username, ... }:

{
  hardware.openrazer.enable = true;

  users.users.${username} = {
    extraGroups = [ "openrazer" ];
  };

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic # Optional GUI for RGB control
  ];
}

