{ config, pkgs, ... }:

{
    imports = [
        ../hardware/xps13.nix
        ../modules/virtualisation.nix
        ../modules/dev.nix
    ];

    boot.initrd.luks = {
        mitigateDMAAttacks = true;
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
}
