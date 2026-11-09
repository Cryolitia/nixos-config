{
  imports = [
    ../../core/level-alpha/nix/droid.nix
    ../../core/level-alpha/nixpkgs/droid.nix
    ../../cli/level-alpha/tools/droid.nix
    ../../cli/level-alpha/network-tools/droid.nix
    ../../cli/level-alpha/git/droid.nix
    ../../cli/level-alpha/gnupg/droid.nix
    ../../cli/level-alpha/neovim/droid.nix
    ../../cli/level-alpha/btop/droid.nix
    ../../cli/level-alpha/hyfetch/droid.nix
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

}
