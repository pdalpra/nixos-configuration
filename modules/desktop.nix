{ config, pkgs, ... }:

{
    services = {
        xserver = {
            enable = true;
            exportConfiguration = true;
            windowManager = {
                default = "i3";
                i3.enable = true;
            };
            displayManager = {
                slim = {
                    enable = true;
                    defaultUser = "pdalpra";
                };
            };
        };
    };

    fonts = {
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fontconfig.ultimate.enable = true;
    };
}
