{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      base = [
        ./modules/devices/hardware-configuration.nix
        ./modules/core/system.nix
        ./modules/core/users.nix
        ./modules/core/apps.nix
      ];
    in
    {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = base ++ [
          ./hosts/server/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };

      laptop = nixpkgs.lib.nixosSystem {
        modules = base ++ [
          ./hosts/laptop/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
