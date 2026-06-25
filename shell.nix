let
  pkgs = import <nixpkgs> {
    config = { };
    overlays = [ ];
  };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    treefmt
    deadnix
    statix
    nixfmt
    kdePackages.qtdeclarative
    nixd
    shfmt
    prettier
  ];

  shellHook = ''
    treefmt -q
  '';
}
