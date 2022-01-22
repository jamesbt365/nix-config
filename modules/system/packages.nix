{ config, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    htop
    btop
    zip
    unzip
    p7zip
    pciutils
    usbutils
    dotnet-sdk
    dotnet-sdk_5
    dotnet-runtime
    inputs.nix-gaming.packages.x86_64-linux.osu-stable
    inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
  ];
  hardware.opentabletdriver.enable = true;
}
