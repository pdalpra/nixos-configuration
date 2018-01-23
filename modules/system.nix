{ config, pkgs, ... }:

{
    system = {
        stateVersion = "17.09";
        autoUpgrade.enable = false;
    };

    boot = {
        hardwareScan   = true;
        tmpOnTmpfs     = true;
        kernelPackages = pkgs.linuxPackages_latest;
    };

    environment = {
        systemPackages = with pkgs; [
            nix-repl
            nox
        ];

        # Minimal global gitconfig to allow --autostash
        # (see autoupgrade unit) to work
        etc."gitconfig" = {
            text = ''
                [user]
                name = root
                email = root@${config.networking.hostName}
            '';
        };
    };

    nix = {
        autoOptimiseStore = true;
        buildCores        = 0;
        useSandbox        = true;
        extraOptions      = ''
            gc-keep-outputs = true
            connect-timeout = 20
        '';
        gc = {
            automatic = true;
            dates     = "03:00";
            options   = "--delete-older-than 14d";
        };
    };

    nixpkgs.config = {
        allowUnfree      = true;
        packageOverrides = pkgs: {
            unstable = import <nixos-unstable> {
                config = config.nixpkgs.config;
            };
        };
    };

    # FIXME: replace hardcoded link to nixos-rebuild by a clean one
    systemd.services.nixos-update = {
        enable                     = true;
        description                = "Upgrade NixOS";
        startAt                    = "weekly";
        unitConfig.X-StopOnRemoval = false;
        serviceConfig = {
            Type             = "oneshot";
            WorkingDirectory = "/etc/nixos";
        };

        environment = config.nix.envVars //
        { inherit (config.environment.sessionVariables) NIX_PATH;
            HOME = "/root";
        };
        path = [
            pkgs.gnutar
            pkgs.xz
            pkgs.git
            config.nix.package.out
        ];
        script = ''
            git pull --autostash --rebase
            /run/current-system/sw/bin/nixos-rebuild switch --upgrade
        '';
    };
}
