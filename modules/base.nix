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
        aspell aspellDicts.en aspellDicts.fr
        bash zsh
        curl wget links
        cryptsetup
        file
        git
        mr
        htop ncdu psmisc pstree
        tree
        uptimed
        usbutils
        vcsh
        vim
        zip unzip
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
