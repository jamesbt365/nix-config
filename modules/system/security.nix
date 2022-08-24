{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = true;
    forwardX11 = true;
  };

  security = {
    polkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}