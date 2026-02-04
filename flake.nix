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

  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video
      nixosConfigurations.nixosTimePC = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
	  {networking.hostName = "nixosTimePC";}
          ./configuration.nix
          inputs.home-manager.nixosModules.default
	  ./hardware-config/nixosTimePC.nix
        ];
      };

      nixosConfigurations.nixosTimeLap = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # this is the important part
        modules = [
	  {networking.hostName = "nixosTimeLap";}
	  ./hardware-config/nixosTimeLap.nix
          ./configuration.nix
        ];
      };
    };
}
