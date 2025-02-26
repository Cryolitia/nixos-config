{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      nerd-fonts.jetbrains-mono
      source-han-serif
      source-han-sans
      noto-fonts-emoji
      shanggu-fonts
      lxgw-wenkai
      arphic-ukai
    ];

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
