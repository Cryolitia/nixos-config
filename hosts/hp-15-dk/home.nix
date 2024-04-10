{ config, ... }:

{

    imports = [
        ../../graphic/home
    ];

    programs.git.signing = {
        signByDefault = true;
        key = "684609BA7B5BC68D";
    };

    home.file.".config/maa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/maa";

    home.file."Documents/template.tex".source = ../../dotfiles/template.tex;

}
