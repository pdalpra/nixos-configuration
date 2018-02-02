{ config, pkgs, ... }:

{
    imports = [
        ../types/laptop.nix
    ];

    boot = {
        blacklistedKernelModules = [
            "psmouse"
            "me" "mei_me"
        ];
        kernelParams = [
            "i915.enable_rc6=1"
        ];
    };

    environment.systemPackages = with pkgs; [
        nvme-cli
    ];

    hardware = {
        bluetooth.enable = true;
    };

    services = {
        tlp.extraConfig = ''
            SOUND_POWER_SAVE_ON_AC = 300
            SOUND_POWER_SAVE_ON_BAT = 300
        '';
        xserver = {
            synaptics.enable = true;
            videoDrivers = ["intel"];
            vaapiDrivers = [pkgs.vaapiIntel];
            inputClassSections = [
                ''
                    Identifier "Generic Keyboard"
                    MatchIsKeyboard "yes"
                    Driver "evdev"
                    Option "XkbLayout"  "fr"
                    Option "XkbVariant" ""
                ''
                ''
                    Identifier "trackpad"
                    MatchisTouchPad "on"
                    Driver "libinput"
                    Option "AccelSpeed"       "1"
                    Option "VertScrollDelta"  "-111"
                    Option "HorizScrollDelta" "-111"
                ''
            ];
    }
}
