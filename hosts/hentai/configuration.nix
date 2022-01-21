{ config, pkgs, inputs, modules, ... }: {
  system.stateVersion = "22.05";
  networking.hostName = "hentai"; # I don't know why i picked this tbh
  time.timeZone = "Europe/London";

  imports = [ 
    ./kernel.nix 
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

  networking = {
    networkmanager.enable = true; # i'll swap it out eventually
  };

  services.xserver = {
    enable = true;
    #    displayManager.startx.enable = true; # proper display managers are for the weak.
    layout = "dvorak"; # us dvorak just in case.
    videoDrivers = [ "amdgpu" ];

    libinput = {
      enable = true;
      mouse = { accelProfile = "flat"; };
    };
  };
  # Temp solution to stuff not working properly with startx, probably due to DISPLAY not setting idk haven't checked.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

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


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  config.pipewire = {
    "context.properties" = {
      "link.max-buffers" = 16;
      "log.level" = 2;
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 64;
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 64;
      "core.daemon" = true;
      "core.name" = "pipewire-0";
    };
    "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -15;
          "rt.prio" = 88;
          "rt.time.soft" = 200000;
          "rt.time.hard" = 200000;
        };
        flags = [ "ifexists" "nofail" ];
      }
      { name = "libpipewire-module-protocol-native"; }
      { name = "libpipewire-module-profiler"; }
      { name = "libpipewire-module-metadata"; }
      { name = "libpipewire-module-spa-device-factory"; }
      { name = "libpipewire-module-spa-node-factory"; }
      { name = "libpipewire-module-client-node"; }
      { name = "libpipewire-module-client-device"; }
      {
        name = "libpipewire-module-portal";
        flags = [ "ifexists" "nofail" ];
      }
      {
        name = "libpipewire-module-access";
        args = {};
      }
      { name = "libpipewire-module-adapter"; }
      { name = "libpipewire-module-link-factory"; }
      { name = "libpipewire-module-session-manager"; }
    ];
  };
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
    inputs.nix-gaming.packages.x86_64-linux.osu-lazer-bin
  ];

  nixpkgs.config.allowUnfree = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

}

