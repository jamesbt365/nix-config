{ config, pkgs, inputs, modules, lib, ... }: {
  system.stateVersion = "23.05";
  networking.hostName = "snowland";
  time.timeZone = "Europe/London";

  imports = with modules.system; [
    inputs.home-manager.nixosModule
    home-manager
    pipewire
    nix
    packages
    gui
    security

    ./kernel.nix
    ./hardware-configuration.nix

    ../../users/lily
  ];
  networking = {
    networkmanager.enable = true;
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
    SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0094", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
