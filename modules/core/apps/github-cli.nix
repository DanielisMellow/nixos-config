{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    github-desktop
    libsecret
    glib
  ];
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true; # optional GUI for managing secrets


}
