{ config, pkgs, ... }:

{
    imports = [
        ../types/laptop.nix
    ];

    boot = {
        kernelModules = ["kvm-intel"];
        initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
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
        opengl.extraPackages = [pkgs.vaapiIntel];
    };

    services = {
        tlp.extraConfig = ''
            SOUND_POWER_SAVE_ON_AC = 300
            SOUND_POWER_SAVE_ON_BAT = 300
        '';
        xserver = {
            dpi = 125;
            synaptics = {
                enable          = true;
                twoFingerScroll = true;
            };
            videoDrivers = ["intel"];
            inputClassSections = [
                ''
                    Identifier "Generic Keyboard"
                    MatchIsKeyboard "yes"
                    Driver "evdev"
                    Option "XkbLayout"  "fr"
                    Option "XkbVariant" ""
                ''
            ];
        };
    };
}
