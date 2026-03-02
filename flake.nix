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
    elephant =
      {
        url = "github:abenz1267/elephant";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, stylix, ... }@inputs:
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

      nixosConfigurations.nixosTimeWork = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          machine-name = "work";
        };
        modules = [
          { networking.hostName = "nixosTimeWork"; }
          ./hardware-config/nixosTimeWork.nix
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
