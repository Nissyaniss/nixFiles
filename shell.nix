let
  pkgs = import <nixpkgs> {
    config = { };
    overlays = [ ];
  };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    statix
    kdePackages.qtdeclarative
    nixd
    shfmt
    prettier
    nixpkgs-fmt
  ];
}
