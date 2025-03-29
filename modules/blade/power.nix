{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tlp
    powertop
    acpi
  ];

  services.tlp.enable = true;
}

