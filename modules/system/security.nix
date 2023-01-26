{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    PermitRootLogin = "no";
    PasswordAuthentication = true;
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