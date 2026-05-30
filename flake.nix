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
  };

  outputs =
    { nixpkgs, stylix, kopuz, ... }@inputs:
    let
      defaultModules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        stylix.nixosModules.stylix
      ];
    in
    {
      nixosConfigurations.nixosTimePC = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit kopuz;
          machine-name = "pc";
        };
        modules = [
          { networking.hostName = "nixosTimePC"; }

          ./hardware-config/nixosTimePC.nix
          {
            home-manager.extraSpecialArgs = {
              inputs = inputs;
              machine-name = "pc";
            };
          }
        ] ++ defaultModules;
      };

      nixosConfigurations.nixosTimeLap = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          machine-name = "laptop";
        };
        modules = [
          { networking.hostName = "nixosTimeLap"; }
          ./hardware-config/nixosTimeLap.nix
          {
            home-manager.extraSpecialArgs = {
              inputs = inputs;
              machine-name = "laptop";
            };
          }
        ] ++ defaultModules;
      };

      nixosConfigurations.dsi-p-tp-13 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          machine-name = "work";
        };
        modules = [
          { networking.hostName = "dsi-p-tp-13"; }
          ./hardware-config/dsi-p-tp-13.nix
          {
            home-manager.extraSpecialArgs = {
              inputs = inputs;
              machine-name = "work";
            };
          }
        ] ++ defaultModules;
      };
    };
}
