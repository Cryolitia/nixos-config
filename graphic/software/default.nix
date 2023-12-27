{ config, pkgs, ... }:

{
  imports =
    [
      ./vscode.nix
      ../../common/software
      ./chrome.nix
      ../../common/yubikey.nix
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
    libsForQt5.okular
    yubikey-manager-qt
    hugo
    kitty
    nordic
    arc-theme
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    qq
    mpv
    vlc
  ];

  programs.kdeconnect.enable = true;
  # security.pam.services.cryolitia.enableKwallet = true;
  services.gnome.gnome-keyring.enable = true;

  programs.clash-verge = {
    enable = true;
    tunMode = true;
  };

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
  
  services.xserver.excludePackages = [ pkgs.xterm ];
}
