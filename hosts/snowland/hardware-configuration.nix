{ config, ... }:
let
  mkMount = label: type: {
    device = "/dev/disk/by-label/${label}";
    fsType = type;
    options = [ "defaults" "noatime" ];
  };
  mkBtrfsMount = subvol:
    mkMount "nixos" "btrfs" // {
      options = [
        "compress-force=zstd"
        "defaults"
        "discard=async"
        "noatime"
        "space_cache=v2"
        "ssd"
        "subvol=${builtins.toString subvol}"
      ];
    };
in {
  fileSystems = {
    "/" = mkBtrfsMount "@";
    "/home" = mkBtrfsMount "@home";
    "/home/.snapshots" = mkBtrfsMount "@home_snapshots";
    "/root" = mkBtrfsMount "@root";
    "/nix" = mkBtrfsMount "@nix";
    "/var" = mkBtrfsMount "@var";

    # Example external storage drive
    "/media/storage" = mkMount "storage" "ext4";
  };
}