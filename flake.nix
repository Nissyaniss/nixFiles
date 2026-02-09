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
  };

  outputs =
    { nixpkgs, stylix, ... }@inputs:
    {
      nixosConfigurations.nixosTimePC = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          machine-name = "pc";
        };
        modules = [
          { networking.hostName = "nixosTimePC"; }
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          ./hardware-config/nixosTimePC.nix
          stylix.nixosModules.stylix
          {
            home-manager.users.nissya.hyprland = {
              enable = true;
              monitor = [
                {
                  output = "DP-2";
                  mode = "2560x1440@144";
                  position = "0x0";
                  scale = 1;
                }
                {
                  output = "HDMI-A-1";
                  mode = "1360x768@60";
                  position = "2560x672";
                  scale = 1;
                }
              ];
            };
            home-manager.extraSpecialArgs = {
              inputs = inputs;
              machine-name = "pc";
            };
          }
        ];
      };

      nixosConfigurations.nixosTimeLap = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          machine-name = "laptop";
        };
        modules = [
          { networking.hostName = "nixosTimeLap"; }
          ./hardware-config/nixosTimeLap.nix
          ./configuration.nix
          stylix.nixosModules.stylix
          {
            home-manager.users.nissya.hyprland = {
              enable = true;
              monitor = [
                {
                  output = "eDP-1";
                  mode = "1920x1080@59.98Hz";
                  position = "0x0";
                  scale = 1;
                }
              ];
            };
            home-manager.extraSpecialArgs = {
              inputs = inputs;
              machine-name = "laptop";
            };
          }
        ];
      };
    };
}
