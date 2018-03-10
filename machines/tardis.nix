{ config, pkgs, ... }:

{
    imports = [
        ../hardware/xps13.nix
        ../modules/virtualisation.nix
        ../modules/dev.nix
    ];

    boot.initrd.luks = {
        mitigateDMAAttacks = true;
        yubikeySupport     = true;
        devices.lvm = {
            device        = "/dev/nvme0n1p2";
            allowDiscards = true;
            preLVM        = true;
        };
    };

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable      = true;
    };

    time.timeZone = "Europe/Paris";

    fileSystems = {
        "/boot" = {
            device  = "/dev/nvme0n1p1";
            fsType  = "vfat";
            options = [
                "rw" "noatime" "nodiratime" "data=orderedrw" "fmask=0022" "dmask=0022"
                "codepage=437" "iocharset=iso8859-1" "shortname=mixed" "errors=remount-ro"
            ];
        };
        "/" = {
            device  = "/dev/mapper/lvm-root";
            fsType  = "ext4";
            options = ["rw" "noatime" "nodiratime" "data=ordered"];
        };
        "/home" = {
            device  = "/dev/mapper/lvm-home";
            fsType  = "ext4";
            options = ["rw" "noatime" "nodiratime" "data=ordered" "nofail"];
        };
        "/var/lib/docker" = {
            device  = "/dev/mapper/lvm-docker";
            fsType  = "ext4";
            options = ["rw" "noatime" "nodiratime" "data=ordered" "nofail"];
        };
    };

    swapDevices = [
        {
            device = " /dev/mapper/lvm-swap";
        }
    ];
}
