{ lib }:
let
  getName = path: lib.removeSuffix ".nix" (
    lib.last (
      lib.splitString "/" (
        builtins.toString path
      )
    )
  );
  mkAttrsFromPaths = paths: builtins.listToAttrs (
    builtins.map
      (path: {
        name = getName path;
        value = path;
      })
      paths
  );
in
{
  system = mkAttrsFromPaths [
    ./system/gui.nix
    ./system/home-manager.nix
    ./system/nix.nix
    ./system/packages.nix
    ./system/pipewire.nix
    ./system/security.nix
  ];
  user = mkAttrsFromPaths [
    ./user/git.nix
    ./user/gpg.nix
    ./user/kitty.nix
    ./user/shell.nix
    ./user/theming.nix
  ];
}
