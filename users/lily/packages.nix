{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    autotiling
    brightnessctl
    btop
    dconf
    discord
    ffmpeg
    firefox-bin
    gamemode
    grim
    keepassxc
    mako
    mpv
    neofetch
    obs-studio
    pavucontrol
    pcmanfm
    polkit_gnome
    prismlauncher
    slurp
    steam
    sway
    vscode
    waybar
    winetricks
    wl-clipboard
    wofi
  ];

}
