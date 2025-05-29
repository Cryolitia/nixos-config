{ config, pkgs, ... }:

{
  imports = [ ./zsh.nix ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    hyfetch
    gh
    btrfs-progs
    tldr
    nnn
    bottom
    gdu
    iperf
    htop
    bat
    btop
    #yazi https://github.com/NixOS/nixpkgs/issues/353119
    zellij
    usbutils
    pciutils
    lazygit
    lm_sensors
    nix-output-monitor
    nixfmt-rfc-style
    gnumake
    smartmontools
    gdb
    udftools
    file
    man-pages
    man-pages-posix
    jq
    mtr
    parted
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nixvim = {
    enable = true;
  } // (import ../../develop/neovim.nix);

  programs.less = {
    enable = true;
    envVariables = {
      LESS = "RFX";
    };
  };
  environment.variables.LESS = "RFX";

  # iperf3
  networking.firewall.allowedTCPPorts = [ 5201 ];
  networking.firewall.allowedUDPPorts = [ 5201 ];
}
