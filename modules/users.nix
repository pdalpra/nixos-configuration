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
                    "wheel"
                    "docker"
                    "audio"
                    "video"
                    "vboxusers"
                ];
            };
        };
    };

    security = {
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