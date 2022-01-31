{ config, pkgs, ... }: {
    programs.kitty = {
    enable = true;
    settings = {
    enable_audio_bell = false; # no sound best
    background = "#222222";
    };
};
}