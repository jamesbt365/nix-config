{ config, pkgs, inputs, modules, ... }: {
  system.stateVersion = "22.05";
  networking.hostName = "hentai"; # I don't know why i picked this tbh
  time.timeZone = "Europe/London";

  imports = [
    # i'm lazy so this will look stupid.
    ../../modules/system/pipewire.nix
    ../../modules/system/nix.nix
    ../../modules/system/packages.nix
    ../../modules/system/xorg.nix

    # host specific
    ./kernel.nix
    ./hardware-configuration.nix
];
  networking = {
    networkmanager.enable = true; # i'll swap it out eventually
  };

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # udev rules
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
    # Wacom CTL-672
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="037b", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="037b", MODE="0666"
    # XP-Pen Star G640
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", MODE="0666"
    SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", ENV{LIBINPUT_IGNORE_DEVICE}=">
  '';
  # shit person
  users.users.james = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}