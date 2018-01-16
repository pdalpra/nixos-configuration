{ config, pkgs, ... }:

{
    programs = {
        bash.enableCompletion = true;
        vim.defaultEditor = true;
        zsh = {
            enable     = true;
            promptInit = "";
        };
    };

    environment.systemPackages = with pkgs; [
        aspell
        aspellDicts.en
        aspellDicts.fr
        bash
        curl
        cryptsetup
        git
        htop
        links
        mr
        ncdu
        psmisc pstree
        tree
        uptimed
        vcsh
        vim
        wget
        zip unzip
        zsh
    ];

    i18n = {
        consoleFont   = "Lat2-Terminus16";
        consoleKeyMap = "fr";
        defaultLocale = "en_US.UTF-8";
    };

    services = {
        uptimed.enable = true;
        nixosManual = {
            enable     = true;
            browser    = "${pkgs.links}/bin/links";
            showManual = true;
        };
    };
}