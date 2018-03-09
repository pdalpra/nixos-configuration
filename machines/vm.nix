{ config, pkgs, ... }:

{
    imports = [
        ../types/desktop.nix
        ../modules/dev.nix
    ];

    boot = {
        loader.grub = {
            enable = true;
            device = "/dev/sda";
        };
        initrd.checkJournalingFS = false;
    };

    time.timeZone = "Europe/Paris";
    services.xserver.layout = "fr";
    virtualisation.virtualbox.guest.enable = true;

    fileSystems."/mnt/virtualbox" = {
        fsType  = "vboxsf";
        device  = "home";
        options = ["noauto,rw"];
    };
}
