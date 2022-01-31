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
    ../../modules/james/shell.nix
    ../../modules/james/kitty.nix
    ../../modules/james/bspwm.nix
    ../../modules/james/sxhkd.nix
    ../../modules/james/xorg.nix
#    ../../modules/james/polybar.nix # fucking polybar takes too long to convert.
# i'll put rofi here soon:tm:
    ../../modules/james/picom.nix
  ];

  home.packages = with pkgs; [
    btop
    discord
    dunst
    ffmpeg
    firefox
    flameshot
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
    polkit_gnome
    rofi
    steam
    sxhkd
    unclutter
    unrar
    vscode
    winetricks
  ];

}
