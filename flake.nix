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
        ./modules/core/system.nix
        ./modules/core/users.nix
        ./modules/core/apps.nix
      ];
    in
    {
    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        modules = base ++ [
          ./hosts/server/hardware-configuration.nix
          ./hosts/server/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };

      laptop = nixpkgs.lib.nixosSystem {
        modules = base ++ [
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dy0gu = import ./modules/home-manager/dy0gu.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };

      virtual = nixpkgs.lib.nixosSystem {
        modules = base ++ [
          ./hosts/virtual/hardware-configuration.nix
          ./hosts/virtual/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dy0gu = import ./modules/home-manager/dy0gu.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
