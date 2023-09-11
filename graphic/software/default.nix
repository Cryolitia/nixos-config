{ config, pkgs, ... }:

{
  imports =
    [
      ./vscode.nix
      ../../common/software
      ../gnome.nix
      ./chrome.nix
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gparted
    telegram-desktop
    github-desktop
    # config.nur.repos.Freed-Wu.netease-cloud-music
    go-musicfox
    nixd
    nixpkgs-fmt
  ];

  programs.chrome.enable = true;

  programs.clash-verge = {
    enable = true;
    tunMode = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "electron-19.0.7"
    "electron-19.1.9"
  ];

  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      source-han-serif
      source-han-sans
      noto-fonts-emoji
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
        sansSerif = [
          "Sarasa Gothic SC"
        ];
        serif = [
          "Source Han Serif SC"
        ];
      };
    };

  };
}