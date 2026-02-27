{ inputs, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    hyfetch
    git
    gh
    tldr
    nnn
    bottom
    gdu
    iperf
    htop
    bat
    btop
    yazi
    zellij
    lazygit
    nix-output-monitor
    gnumake
    file
    man-pages
    man-pages-posix
    jq
    fastfetch
    dig
    firefox
    (import ../../common/software/nixfmt.nix { inherit pkgs; })
    nur-cryolitia.pgp-sig2dot
    (inputs.nixvim.legacyPackages."${system}".makeNixvim (
      (import ../../common/software/neovim.nix)
      // {
        clipboard.providers.wl-copy.enable = false;
      }
    ))
    (import ../../graphic/software/vscode.nix {
      inherit inputs pkgs;
    })
    fzf
    nixd
    kitty
    comma
  ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.rev or inputs.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.primaryUser = "cryolitia";

  nixpkgs.config.allowUnfree = true;

  environment = {
    enableAllTerminfo = true;
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      EDITOR = "nvim";
    };
  };

  networking.hostName = "Cryolitia-MacBook-Air";

  nix = {
    package = pkgs.lix;
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 4;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
    linux-builder.enable = true;

    settings = {
      auto-optimise-store = true;
      trusted-users = [
        "root"
        "cryolitia"
      ];
      experimental-features = "nix-command flakes";

      substituters = [
        "https://mirrors.mirrorz.org/nix-channels/store"
        # "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"

        "https://nix-community.cachix.org"
        "https://cryolitia.cachix.org"
        "http://cache.cryolitia.dn42"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cryolitia.cachix.org-1:/RUeJIs3lEUX4X/oOco/eIcysKZEMxZNjqiMgXVItQ8="
        "kp920.cryolitia.dn42:M68UcYMNX/2yWXFwDb21jAregdcIsF3uIrSmXldX70k="
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    enableFastSyntaxHighlighting = true;
    histSize = 1000000;
    interactiveShellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };

  fonts.packages = (import ../../graphic/software/fontPackages.nix { inherit pkgs; });

  users.users.cryolitia = {
    description = "Cryolitia PukNgae";
    home = "/Users/cryolitia";
    isHidden = false;
    uid = 501;
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

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      "com.apple.keyboard.fnState" = true;
    };
    loginwindow.GuestEnabled = false;
  };
}
