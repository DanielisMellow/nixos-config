{ inputs
, outputs
, lib
, config
, pkgs
, username
, ...
}:
{
  imports = [
    <nixos-wsl/modules>
    ./../../modules/core/wsl-defaults.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = ${username};

  environment.systemPackages = with pkgs;
    [
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
