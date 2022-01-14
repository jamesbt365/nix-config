{ config, pkgs, ... }: {
    programs.kitty = {
    enable = true;
    settings = {
    enable_audio_bell = false;
    background = "#222222";
    };
};
}