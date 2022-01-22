{ config, pkgs, ... }:
{
  home.username = "james";
  home.homeDirectory = "/home/james";
  home.stateVersion = "22.05";

  # do i need this now?
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    minecraft
    winetricks
    steam
    mpv
    krita
    neofetch
    firefox
    obs-studio
    noisetorch
    brightnessctl
    pavucontrol
    discord
    rofi
    bspwm
    sxhkd
    pcmanfm
    kitty
    polybar
    unclutter
    flameshot
    dunst
    picom
    nitrogen
    vscode
  ];

}
