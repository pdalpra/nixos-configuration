{ config, lib, pkgs, ... }:

{
    services.udev.extraRules = ''
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
        ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
        KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
    '';

    config = mkIf services.xserver.enable {
        services.xserver.inputClassSections = [
            ''
                Identifier      "ErgoDox"
                MatchIsKeyboard "on"
                MatchUSBID      "feed:1307"
                Driver          "evdev"
                Option          "XkbLayout"     "fr"
                Option          "XkbVariant"    "bepo"
            ''
        ];
    };
}