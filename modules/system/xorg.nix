{ configs, pkgs, ... }: {
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
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
}
