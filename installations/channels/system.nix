let
  finix = import <finix>;
  pkgs = import <nixpkgs> { };
in
finix.lib.finixSystem {
  inherit (pkgs) lib;

  modules = [
    { nixpkgs.pkgs = pkgs; }
    ./configuration.nix
  ];
}
