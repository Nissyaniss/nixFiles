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

  personnalUsers =
    if machine-name != "work" then {
      "nissya" = import ./nissya.nix;
    } else { };
in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    users = {
      "root" = import ./root.nix;
    } // workAdditionnalUsers // personnalUsers;
  };
}
