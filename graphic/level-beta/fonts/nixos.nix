{ pkgs, ... }:

{
  fonts = {
    packages = (import ./packages.nix { inherit pkgs; });

    fontconfig = {
      defaultFonts = {
        emoji = [
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
        monospace = [
          "Sarasa Mono SC"
          "JetBrainsMono Nerd Font Mono"
        ];
        sansSerif = [ "Sarasa Gothic SC" ];
        serif = [ "Source Han Serif SC" ];
      };
      cache32Bit = true;
    };
  };
}
