# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nordVpnPkg = pkgs.callPackage ./nordvpn-package { };
}
