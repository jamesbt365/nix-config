{ config, pkgs, ... }: {
  home.username = "james";
  home.homeDirectory = "/home/james";
  home.stateVersion = "22.05";

  # do i need this now?
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/james/git.nix
    #     ../../modules/james/theming.nix # this causes home-manager to just refuse?
  ];

  home.packages = with pkgs; [
    bspwm
    btop
    discord
    dunst
    ffmpeg
    firefox
    flameshot
    kitty
    krita
    minecraft
    mpv
    neofetch
    nitrogen
    noisetorch
    obs-studio
    p7zip
    pavucontrol
    pcmanfm
    picom
    polybar
    rofi
    steam
    sxhkd
    unclutter
    unrar
    vscode
    winetricks
  ];

}
