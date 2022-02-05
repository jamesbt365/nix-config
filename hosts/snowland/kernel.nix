{ config, pkgs, lib, ... }: {
  boot = {
  kernelPackages = pkgs.linuxPackages_zen;
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.kernelModules = [ "amdgpu" ];
  };
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [ "kvm-amd" "rtl8821ce" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8821ce ];
  zramSwap.enable = true;
}
