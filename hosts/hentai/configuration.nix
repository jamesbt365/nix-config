# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    binaryCaches = [ "https://nix-gaming.cachix.org" ];
    binaryCachePublicKeys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
    trustedUsers = [ "root" "@wheel" ];
  };

  # Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.kernelModules = [ "amdgpu" ];
  };

  networking = {
    hostName = "hentai"; # I don't know why i picked this tbh
    networkmanager.enable = true; # i'll swap it out eventually
  };

  services.xserver = {
    enable = true;
    displayManager.startx.enable =
      true; # proper display managers are for the weak.
    layout = "dvorak"; # us dvorak just in case.
    videoDrivers = [ "amdgpu" ];

    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
    };
  };

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # tablet driver
  hardware.opentabletdriver.enable = true;

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

  # pipewire stuff so i can hear sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    config.pipewire = { };
  };
  # shit person
  users.users.james = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
  ];

  # mmm unfree software
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

