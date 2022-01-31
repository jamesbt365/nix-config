{ config, ... }: {
    services.picom = {
    enable = true;
    vSync = true;
    refresh-rate = 144;
}