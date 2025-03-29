{
  description = "Your new nix config";

  inputs = {
    # Stable nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # Unstable for newer packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    inherit (self) outputs;

    username = "lizardking";

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages, available via 'nix build', 'nix shell', etc.
    packages = forAllSystems (system:
      import ./pkgs nixpkgs.legacyPackages.${system}
    );

    # Formatter for nix files
    formatter = forAllSystems (system:
      nixpkgs.legacyPackages.${system}.alejandra
    );

    # Export reusable modules
    nixosModules = import ./modules/core;

    # Define your NixOS systems
    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs username;
          host = "vm";
        };
        modules = [ ./hosts/vm/configuration.nix ];
      };

      blade = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs username;
          host = "blade";
        };
        modules = [ ./hosts/blade/configuration.nix ];
      };
    };
  };
}

