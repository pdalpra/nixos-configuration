{ config, pkgs, ... }:

let
    machine = (import ./machine.nix).machine;
    customImport = if builtins.pathExists ./custom.nix then [./custom.nix] else [];
    baseImports = [
        ./hardware-configuration.nix
        (./machines + "/${machine}.nix")
    ];
in
{
    networking.hostName = "${machine}";
    imports = baseImports ++ customImport;
}
