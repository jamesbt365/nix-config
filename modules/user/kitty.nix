{ config, pkgs, ... }: {
    programs.kitty = {
    enable = true;
    settings = {
    background_opacity = "0.85";
    enable_audio_bell = false;
    foreground = "#FFFCFF";
    background = "#0A0D0F";
    };
};
}