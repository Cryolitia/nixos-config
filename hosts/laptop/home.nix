{ config, pkgs, ... }:

{

    imports = [
        ../../graphic/home
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "C0C35E0CE6B1D1D0";
    };

}