{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot";
  boot.initrd.luks.devices."luks-60c85ad2-540b-4058-9173-f830c4ddcb95".device = "/dev/disk/by-uuid/60c85ad2-540b-4058-9173-f830c4ddcb95";
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_6_6;
}

