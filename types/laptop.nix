{ config, pkgs, ... }:

{
    imports = [
        ../modules/base.nix
        ../modules/desktop.nix
        ../modules/audio_video.nix
        ../modules/networking.nix
        ../modules/system.nix
        ../modules/users.nix
        ../modules/virtualisation.nix
    ];

    services = {
        acpid.enable = true;
        tlp.enable  = true;
    };

    powerManagement.powertop.enable = true;

    environment.systemPackages = with pkgs; [
        lm_sensors
        pmutils
    ];
}
