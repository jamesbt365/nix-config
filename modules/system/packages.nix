{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    ncdu
    neovim
    sshfs
    rsync
    git
    vim
    pciutils
    cryptsetup
    cachix
    inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
    inputs.nix-gaming.packages.x86_64-linux.osu-stable
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;

  hardware.opentabletdriver.enable = true;
  programs.gnupg.agent.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
}
