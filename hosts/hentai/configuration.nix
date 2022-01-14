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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "hentai"; # I'm very funny

  # amdgpu
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # not the best solution but it "works"
  networking.networkmanager.enable = true;

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

  # xorg lol
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
      touchpad = { accelProfile = "flat"; };
    };
  };
  # sddm cringe
  services.xserver.displayManager.sddm.enable = true;

  # you know how i need this thing to use my computer without having a mental breakdown
  services.xserver.windowManager.bspwm.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "dvorak"; # dvorak haha

  # Temp pipewire shit
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # shit person
  users.users.james = {
    isNormalUser = true;
    initialPassword = "test";
    extraGroups = [ "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      wget
      git
      vim
      htop
      btop
      zip
      unzip
      p7zip
#      neofetch
      pciutils
      usbutils
      firefox
      bspwm
      sxhkd
      dotnet-sdk
      dotnet-sdk_5
      dotnet-runtime
    ] ++ (with inputs.nix-gaming.packages.x86_64-linux; [ osu-stable ]);

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

