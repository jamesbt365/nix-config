{ config, pkgs, ... }: {

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
