{ pkgs, ... }:

{
  imports =
    [
      ./vscode.nix
      ../../common/software
      ./chrome.nix
      ../../hardware/yubikey.nix
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
    hugo
    kitty
    nordic
    arc-theme
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    qq
    mpv
    vlc
    blackbox-terminal
    libnotify
    mission-center
    typst
    warp-terminal
  ];

  programs.kdeconnect.enable = true;
  # security.pam.services.cryolitia.enableKwallet = true;
  services.gnome.gnome-keyring.enable = true;

  programs.clash-verge = {
    enable = true;
    tunMode = true;
    package = pkgs.clash-verge-rev;
  };

  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      source-han-serif
      source-han-sans
      noto-fonts-emoji
      nur-cryolitia.shanggu-fonts
      shanggu-fonts
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
