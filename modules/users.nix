{ config, pkgs, ... }:

{
    users = {
        defaultUserShell = pkgs.bash;
        extraUsers = {
            pdalpra = {
                isNormalUser    = true;
                uid             = 1000;
                initialPassword = "password";
                shell           = pkgs.zsh;
                extraGroups     = [
                    "audio"
                    "docker"
                    "network"
                    "video"
                    "vboxusers"
                    "wheel"
                ];
            };
        };
    };

    security = {
        polkit.enable = true;
        sudo = {
            enable             = true;
            wheelNeedsPassword = false;
        };
        pam = {
            enableU2F = true;
            services.pdalpra.u2fAuth = true;
        };
    };
}
