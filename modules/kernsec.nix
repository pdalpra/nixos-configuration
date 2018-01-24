{ config, lib, pkgs, ... }:

with lib;

{
    security.apparmor.enable = true;

    boot.blacklistedKernelModules = [
        "ax25"
        "netrom"
        "rose"
    ];

    boot.kernelParams = [
        "vsyscall=none"
        "nohibernate"
    ];

    boot.kernel.sysctl = {
        "kernel.kptr_restrict" = mkOverride 500 1;
        "kernel.dmesg_restrict" = true;
        "kernel.kexec_load_disabled" = true;
        "kernel.yama.ptrace_scope" = 1;
        "user.max_user_namespaces" = 0;
    };

    nixpkgs.config.packageOverrides = pkgs: {
        linux_4_14 = pkgs.linux_4_14.override {
            extraConfig = ''
              BINFMT_MISC              n
              LEGACY_PTYS              n
              INET_DIAG                n
              COMPAT_VDSO              n
              COMPAT_BRK               n
              BUG                      y
              DEBUG_KERNEL             y
              DEBUG_WX                 y
              CC_STACKPROTECTOR        y
              CC_STACKPROTECTOR_REGULAR n
              CC_STACKPROTECTOR_STRONG y
              KEXEC                    n
              STRICT_DEVMEM            y
              DEBUG_CREDENTIALS        y
              DEBUG_NOTIFIERS          y
              DEBUG_LIST               y
              DEBUG_SG                 y
              BUG_ON_DATA_CORRUPTION   y
              SCHED_STACK_END_CHECK    y
              IO_STRICT_DEVMEM         y
              PROC_KCORE               n
              ACPI_CUSTOM_METHOD       n
              FORTIFY_SOURCE           y
              REFCOUNT_FULL            y
              SLAB_FREELIST_RANDOM     y
              SLAB_HARDENED            y
              SLUB_DEBUG               y
              DEVKMEM                  n
              HIBERNATION              n
              HARDENED_USERCOPY        y
              LEGACY_VSYSCALL_NONE     y
              IA32_EMULATION           n
            '';
        };
    };
}