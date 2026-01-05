{ inputs, pkgs, ... }:

{
  # Simply install just the packages
  environment.packages = with pkgs; [
    # (import ../../common/software/nixfmt.nix { inherit pkgs; })
    (inputs.nixvim.legacyPackages."${system}".makeNixvim (import ../../common/software/neovim.nix))
    openssh
    gnupg
    fastfetch
    hyfetch
    iperf
    dig
    mtr
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";

  # Configure home-manager
  home-manager = {
    config = ./home.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };
}
