{ config, lib, modules, pkgs, ... }: {
  users.users.riley = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  home-manager.users.lily = { config, enableGUI, lib, pkgs, ... }: {
    home = {
      username = "riley";
      homeDirectory = "/home/riley";
      stateVersion = "22.05";
    };

    imports = with modules.user; [
      ./packages.nix

      git
      theming
      shell
      kitty
      bspwm # this works but i'm sick of being a moron with it
      sxhkd
      xorg
      gpg
      #    ../../modules/user/polybar.nix # fucking polybar takes too long to convert.
      # i'll put rofi here soon:tm:
      picom
    ];
  };
}
