{ config, pkgs, ... }:

{
    virtualisation = {
        virtualbox.host.enable = true;

        docker = {
            enable           = true;
            enableOnBoot     = true;
            package          = pkgs.docker;
            storageDriver    = "overlay2";
            autoPrune.enable = true;
        };
    };
}