{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    ncdu
    neovim
    ntfs3g
    sshfs
    gparted
    rsync
    git
    vim
    pciutils
    cryptsetup
    dotnet-sdk
    dotnet-sdk_5
    dotnet-runtime
    inputs.nix-gaming.packages.x86_64-linux.osu-stable
    inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
  ];
  environment.variables.EDITOR = "nvim";
  programs.adb.enable = true;

  hardware.opentabletdriver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
}
