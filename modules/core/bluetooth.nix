{ config, lib, pkgs, ... }:

{
  services.blueman.enable = true;
  # Optional: useful for proprietary Bluetooth/wifi firmware
  hardware.enableAllFirmware = true;
}
