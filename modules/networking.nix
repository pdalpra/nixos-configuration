{ config, lib, pkgs, ... }:

let
    vpn_configs_root = /etc/vpn_configs;
    contents = builtins.readDir vpn_configs_root;
    candidateDirs = builtins.attrNames (builib.filterAttrs (path: type: type == "directory") contents);
    configDirs = builtins.filter (path: builtins.pathExists path/config.ovpn)  (builtins.map builtins.toPatg candidateDirs);
in {
    networking = {
        firewall.enable = false;
        extraHosts = ''
            127.0.0.1 localdocker
        '';
        nameservers = [
            # Google DNS
            "8.8.8.8"
            "8.8.4.4"
        ];
        timeServers = [
            "0.europe.pool.ntp.org"
            "1.europe.pool.ntp.org"
            "2.europe.pool.ntp.org"
            "3.europe.pool.ntp.org"
        ];
        networkmanager = {
            enable = true;
            insertNameservers = config.networking.nameservers;
            packages =  with pkgs; [
                networkmanager_l2tp
                networkmanager_openvpn
            ];
        };
    };

    config = lib.mkIf builtins.length configDirs > 0 {
        let
            vpnConfig = { path }:
                {
                    "${path}".autoStart = false;
                    "${path}".config    = builtins.readFile path; 
                }
        in map vpnConfig configDirs;
    };
}