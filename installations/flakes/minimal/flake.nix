{
  description = "Minimal finix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    finix.url = "github:finix-community/finix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      finix,
      ...
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      nixosConfigurations.finixos = finix.lib.finixSystem {
        inherit (pkgs) lib;

        modules = [
          { nixpkgs.pkgs = pkgs; }
          ./configuration.nix
        ];
      };
    };
}
