{ configs, pkgs, lib, ... }: {
#  fonts are literally just stolen from lava tbf
    fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "NotoSerif" ];
        sansSerif = [ "NotoSans" ];
        monospace = [ "CascadiaCode" ];
      };
    };
    fonts = with pkgs; [
      cascadia-code
      font-awesome-ttf
      font-awesome_4
      hanazono
      material-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      open-sans
      twemoji-color-font
      unifont
    ];
  };
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    layout = "dvorak";
    videoDrivers = [ "amdgpu" ];
    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
    };
  };
}
