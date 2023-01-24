{ config, pkgs, lib, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_5_15;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.kernelModules = [ "amdgpu" ];
  };
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "ahci_pci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-amd" "rtl8723de" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8723de ];
  zramSwap.enable = true;
}

# rtw88-8723de