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
            "i915.enable_psr=0"
            "i915.enable_rc6=1"
            "i915.enable_guc_loading=1"
            "i915.enable_guc_submission=1"
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
            CPU_SCALING_GOVERNOR_ON_AC=powersave
            CPU_SCALING_GOVERNOR_ON_BAT=powersave
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
