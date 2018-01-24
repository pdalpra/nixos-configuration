{ config, pkgs, ... }:

{
    nixpkgs.config.packageOverrides = pkgs: {
        linux_4_14 = pkgs.linux_4_14.override {
            extraConfig = ''
              DEBUG_WX             y
              KEXEC                n
              IO_STRICT_DEVMEM     y
              PROC_KCORE           n
              ACPI_CUSTOM_METHOD   n
              FORTIFY_SOURCE       y
              REFCOUNT_FULL        y
              SLAB_FREELIST_RANDOM y
              HARDENED_USERCOPY    y
            '';
        };
    };
}