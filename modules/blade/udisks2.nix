{ config, lib, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    udisks2
    udiskie
  ];
  services.udisks2.enable = true; # <-- Important!
}
