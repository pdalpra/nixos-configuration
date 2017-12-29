{ config, pkgs, ... }:

{
    imports = [
        ../hardware/xps13.nix
        ../modules/virtualisation.nix
        ../modules/dev.nix
    ];

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable      = true;
    };

    time.timeZone = "Europe/Paris";
}