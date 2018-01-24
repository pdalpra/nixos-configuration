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
              ACPI_CUSTOM_METHOD        n
              BUG                       y
              BUG_ON_DATA_CORRUPTION    y
              CC_STACKPROTECTOR         y
              CC_STACKPROTECTOR_REGULAR n
              CC_STACKPROTECTOR_STRONG  y
              COMPAT_BRK                n
              DEBUG_CREDENTIALS         y
              DEBUG_KERNEL              y
              DEBUG_LIST                y
              DEBUG_NOTIFIERS           y
              DEBUG_SG                  y
              DEBUG_WX                  y
              DEVKMEM                   n
              FORTIFY_SOURCE            y
              HARDENED_USERCOPY         y
              HIBERNATION               n
              IA32_EMULATION            n
              INET_DIAG                 n
              IO_STRICT_DEVMEM          y
              KEXEC                     n
              LEGACY_PTYS               n
              LEGACY_VSYSCALL_NONE      y
              PROC_KCORE                n
              REFCOUNT_FULL             y
              SCHED_STACK_END_CHECK     y
              SECURITY_SELINUX_DISABLE  n
              SLAB_FREELIST_RANDOM      y
              SLUB_DEBUG                y
              STRICT_DEVMEM             y
            '';
        };
    };
}