let
  finix = import <finix>;
in
finix.lib.finixSystem {
  lib = import <nixpkgs/lib>;

  modules = [
    ./configuration.nix
  ] ++ builtins.attrValues finix.nixosModules;
}
