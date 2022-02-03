{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    htop
    pciutils
    dotnet-sdk
    dotnet-sdk_5
    dotnet-runtime
    inputs.nix-gaming.packages.x86_64-linux.osu-stable
    inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
  ];
  hardware.opentabletdriver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
}
