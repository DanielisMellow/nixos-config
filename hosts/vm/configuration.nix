{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/vm
  ];


  # kvm/qemu doesn't use UEFI firmware mode by default.
  # so we force-override the setting here
  # and configure GRUB instead.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = false;

  environment.systemPackages = with pkgs; [
  spice-vdagent
  ];

  # List services that you want to enable:
  services.spice-vdagentd.enable = true;

  # allow local remote access to make it easier to toy around with the system
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      PermitRootLogin = "yes";
    };
  };

}
