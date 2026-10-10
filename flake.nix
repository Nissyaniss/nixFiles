{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkHost =
        hostname: system:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.default
            {
              networking.hostName = hostname;
              home-manager.extraSpecialArgs = { inherit inputs system; };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixosTimePC = mkHost "nixosTimePC" "x86_64-linux";
        nixosTimeLap = mkHost "nixosTimeLap" "x86_64-linux";
        nixosTimeWork = mkHost "nixosTimeWork" "x86_64-linux";
      };
    };
}
