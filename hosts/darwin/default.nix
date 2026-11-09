{ inputs, pkgs, ... }:

{
  imports = [
    ../../core/level-alpha/nixpkgs/darwin.nix
    ../../core/level-alpha/nix/darwin.nix
    ../../core/level-alpha/system/darwin.nix
    ../../core/level-beta/home-manager/darwin.nix
    ../../cli/level-alpha/tools/darwin.nix
    ../../cli/level-alpha/network-tools/darwin.nix
    ../../cli/level-alpha/zsh/darwin.nix
    ../../cli/level-alpha/git/darwin.nix
    ../../cli/level-alpha/gnupg/darwin.nix
    ../../cli/level-alpha/neovim/darwin.nix
    ../../cli/level-alpha/btop/darwin.nix
    ../../cli/level-alpha/hyfetch/darwin.nix
    ../../cli/level-alpha/nix-index/darwin.nix
    ../../cli/level-alpha/formatter/darwin.nix
    ../../graphic/level-beta/desktop-base/darwin.nix
    ../../graphic/level-beta/fonts/darwin.nix
    ../../graphic/level-beta/kitty/darwin.nix
    ../../graphic/level-beta/vscode/darwin.nix
    ../../graphic/level-beta/input-method/darwin.nix
    ../../graphic/level-beta/localsend/darwin.nix
  ];

  home-manager.users.cryolitia.imports = [ ./home.nix ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "cryolitia";

  networking.hostName = "Cryolitia-MacBook-Air";

  users.users.cryolitia = {
    description = "Cryolitia PukNgae";
    home = "/Users/cryolitia";
    isHidden = false;
    uid = 501;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKUCnYwJzdXqbPO2Y92jSSSCTW+u5oH06meRqx0HR8Hd Cryolitia@gmail.com"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2mmQ5YQrQyUSYRNvRKTgYiTSdPt3wtCdiY0YBD7+X9 openpgp:0xA2647D3C"
    ];
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

}
