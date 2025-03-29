{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
    ./../../modules/blade
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent
  ];
  # List services that you want to enable:
  services.spice-vdagentd.enable = true;
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
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
