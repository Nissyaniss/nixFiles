{ inputs
, self
, machine-name
, ...
}:
let
  workAdditionnalUsers =
    if machine-name == "work" then {
      "lasbop01" = import ./lasbop01.nix;
    } else { };
in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    users = {
      "nissya" = import ./nissya.nix;
      "root" = import ./root.nix;
    } // workAdditionnalUsers;
  };
}
