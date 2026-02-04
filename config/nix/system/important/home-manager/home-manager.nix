{ inputs
, self
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    users = {
      "nissya" = import ./nissya.nix;
      "root" = import ./root.nix;
    };
  };
}
