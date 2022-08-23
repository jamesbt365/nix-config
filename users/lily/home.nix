{ config, pkgs, ... }: {
  home.username = "lily";
  home.homeDirectory = "/home/lily";
  home.stateVersion = "22.05";

  # do i need this now?
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../../modules/user/git.nix
    ../../modules/user/theming.nix
    ../../modules/user/shell.nix
    ../../modules/user/kitty.nix
#    ../../modules/user/bspwm.nix # this works but i'm sick of being a moron with it
    ../../modules/user/sxhkd.nix
    ../../modules/user/xorg.nix
#    ../../modules/user/polybar.nix # fucking polybar takes too long to convert.
# i'll put rofi here soon:tm:
    ../../modules/user/picom.nix
  ];

  #   nixpkgs.overlays = [
  #   (import ../../overlays/idonthaveoneyet)
  # ];

  home.packages = with pkgs; [
    discord-canary
    dconf
    dunst
    ffmpeg
    firefox
    flameshot
    krita
    polymc
    mpv
    neofetch
    easyeffects
    obs-studio
    pavucontrol
    pcmanfm
    picom
    polkit_gnome
    polybar
    rofi
    steam
    sxhkd
    unclutter
    vscodium
    winetricks
    gamemode
    dconf
    xorg.xgamma
  ];

}
