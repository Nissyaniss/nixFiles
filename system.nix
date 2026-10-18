let
  sources = import ./npins;

  mkHost =
    system: hostName:
    import "${sources.nixpkgs}/nixos" {
      inherit system;
      specialArgs = { inherit sources system hostName; };
      configuration = {
        imports = [
          ./hosts/${hostName}
          "${sources.home-manager}/nixos"
        ];
        networking.hostName = hostName;
        home-manager.extraSpecialArgs = {
          inherit sources system hostName;
        };
        nixpkgs.flake.source = sources.nixpkgs.outPath;
      };
    };
in
{
  nixosTimePC = mkHost "x86_64-linux" "nixosTimePC";
}
