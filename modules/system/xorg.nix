{ configs, pkgs, lib, ... }: {
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
      font-awesome
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
