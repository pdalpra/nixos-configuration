{ config, pkgs, ... }:

let
    machine = (import ./machine.nix).machine;
in
{
    networking.hostName = "${machine}";

    imports = [
        ./hardware-configuration.nix
        (./machines + "/${machine}.nix")
    ];
}
