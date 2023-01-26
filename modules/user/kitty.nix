{ config, pkgs, ... }: {
    programs.kitty = {
    enable = true;
    settings = {
    background_opacity = "0.85";
    enable_audio_bell = false;
    foreground = "#e0def4";
    background = "#191724";
    };
};
}