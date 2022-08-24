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
    ./user/bspwm.nix
    ./user/direnv.nix
    ./user/rofi.nix
    ./user/dunst.nix
    ./user/emacs.nix
    ./user/git.nix
    ./user/kitty.nix
    ./user/picom.nix
    ./user/gpg.nix
    ./user/shell.nix
    ./user/gpg.nix
    ./user/neovim-minimal.nix
    ./user/polybar.nix
    ./user/theming.nix
    ./user/sessionVariables.nix
    ./user/sxhkd.nix
    ./user/xdg.nix
    ./user/xorg.nix
    ./user/zsh.nix
  ];
}
