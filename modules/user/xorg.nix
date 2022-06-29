{ config, ... }: {
    xdg.configFile."xorg/.xinitrc".source = ../../scripts/.xinitrc;
}
