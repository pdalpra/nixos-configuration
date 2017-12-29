{ config, pkgs, ... }:

{
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
    };
}