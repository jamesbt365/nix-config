{ config, lib, modules, pkgs, ... }: {
  users.users.lily = {
    isNormalUser = true;
    initialPassword = "nixos";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  home-manager.users.lily = { config, enableGUI, lib, pkgs, ... }: {
    home = {
      username = "lily";
      homeDirectory = "/home/lily";
      stateVersion = "23.05";
    };

    imports = with modules.user; [
      ./packages.nix

      git
      gpg
      kitty
      shell
      theming
    ];
  };
}
