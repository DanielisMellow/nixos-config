{ config, lib, pkgs,username, ... }:

let
  nordVpnPkg = pkgs.callPackage ../../../pkgs/nordvpn-package.nix {};
in
{
  options.services.nordvpn.enable = lib.mkEnableOption "Enable NordVPN daemon";

  config = lib.mkIf config.services.nordvpn.enable {

    # Firewall rules for NordVPN
    networking.firewall = {
      checkReversePath = false;
      allowedUDPPorts = [ 1194 ];
      allowedTCPPorts = [ 443 ];
    };

    # Install NordVPN package
    environment.systemPackages = [ nordVpnPkg ];

    # Create the 'nordvpn' group and add the user
    users.groups.nordvpn = {};
    users.users.${username}.extraGroups = [ "nordvpn" ];

    # Systemd service for NordVPN daemon
    systemd.services.nordvpn = {
      description = "NordVPN daemon";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${nordVpnPkg}/bin/nordvpnd";
        ExecStartPre = pkgs.writeShellScript "nordvpn-start" ''
          mkdir -m 700 -p /var/lib/nordvpn;
          if [ -z "$(ls -A /var/lib/nordvpn)" ]; then
            cp -r ${nordVpnPkg}/var/lib/nordvpn/* /var/lib/nordvpn;
          fi
        '';
        NonBlocking = true;
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
        RuntimeDirectory = "nordvpn";
        RuntimeDirectoryMode = "0750";
        Group = "nordvpn";
      };
    };
  };
}

