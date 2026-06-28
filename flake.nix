{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kopuz.url = "github:temidaradev/kopuz";

    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      lazyvim,
      ...
    }@inputs:
    let
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.default
            stylix.nixosModules.stylix
            {
              networking.hostName = hostname;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.sharedModules = [ lazyvim.homeManagerModules.default ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixosTimePC = mkHost "nixosTimePC";
        nixosTimeLap = mkHost "nixosTimeLap";
        nixosTimeWork = mkHost "nixosTimeWork";
      };
    };
}
