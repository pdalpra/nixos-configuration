{ config, pkgs, ... }:

{
    config = mkIf services.xserver.enable {
        services.xserver.inputClassSections = [
            ''
                Identifier      "TypeMatrix"
                MatchIsKeyboard "on"
                MatchVendor     "TypeMatrix.com"
                MatchProduct    "USB Keyboard"
                Driver          "evdev"
                Option          "XbkModel"      "tm2030USB"
                Option          "XkbLayout"     "fr"
                Option          "XkbVariant"    "bepo"
            ''
        ];
    };
}